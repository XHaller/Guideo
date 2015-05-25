//
//  EventViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteDetailViewController.h"
#import "SearchDisplayController.h"
#import "tableData.h"
#import "DataTransfer.h"
#import "ImageScaler.h"

@interface NoteViewController ()
{
    SearchDisplayController *search;
}
@end

@implementation NoteViewController{
    __weak IBOutlet UITableView *_tableView;
}

@synthesize notes;
@synthesize searchResults;
@synthesize imageCache, imageDownloadingQueue;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Notes";
    
    // [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextColor,[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], UITextAttributeFont, nil]];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    notes = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];
    
    NSDictionary *keyPair = @{@"note": @"1"};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/note" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger noteNum = 0;
    if(jsonData != NULL)
    {
        noteNum = [jsonData count];
        
        NSLog(@"Note Number: %lu", (unsigned long)noteNum);
    }
    
    for(int i = 0; i < noteNum; i++)
    {
        tableData *note = [tableData new];
        note.tableTopic = [jsonData objectAtIndex:i][@"user"];
        note.tableContent = [jsonData objectAtIndex:i][@"topic"];
        note.tableImage = [jsonData objectAtIndex:i][@"image"];
        
        [notes addObject:note];
        
    }
    
    //    tableData *event1 = [tableData new];
    //    event1.tableTopic = @"One day cruise";
    //    event1.tableContent = @"The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. ";
    //    event1.tableImage = @"image1.jpg";
    //
    //    [events addObject:event1];
    //
    //    tableData *event2 = [tableData new];
    //    event2.tableTopic = @"Discount ticket!";
    //    event2.tableContent = @"The Metropolitan Museum of Art (colloquially The Met), located in New York City, is the largest art museum in the United States and one of the ten largest in the world.";
    //    event2.tableImage = @"image2.jpg";
    //
    //    [events addObject:event2];
    //
    //    tableData *event3 = [tableData new];
    //    event3.tableTopic = @"Picnic at noon";
    //    event3.tableContent = @"Central Park is an urban park in the central part of the borough of Manhattan, New York City.";
    //    event3.tableImage = @"image3.jpg";
    //
    //    [events addObject:event3];
    //
    //    tableData *event4 = [tableData new];
    //    event4.tableTopic = @"Climb to the sky";
    //    event4.tableContent = @"The Empire State Building is a 102-story skyscraper located in Midtown Manhattan, New York City, on Fifth Avenue between West 33rd and 34th Streets.";
    //    event4.tableImage = @"image4.jpg";
    //
    //    [events addObject:event4];
    //
    //    tableData *event5 = [tableData new];
    //    event5.tableTopic = @"Island Sale!";
    //    event5.tableContent = @"Ellis Island is an island that is located in Upper New York Bay in the Port of New York and New Jersey, United States Of America.";
    //    event5.tableImage = @"image5.jpg";
    //
    //    [events addObject:event5];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    UISearchBar *mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    [self.view addSubview:mySearchBar];
    
    mySearchBar.barTintColor = [UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0];
    mySearchBar.tintColor = [UIColor whiteColor];
    mySearchBar.placeholder = @"Search Events";
    //mySearchBar.showsScopeBar = NO;
    
    for (UIView* subview in [[mySearchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            [textField setBackgroundColor:[UIColor colorWithRed:96/255.0 green:215/255.0 blue:255/255.0 alpha:0.3]];
        }
    }
    
    // create the Search Display Controller with the above Search Bar
    search = [[SearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    search.searchResultsDataSource = self;
    search.searchResultsDelegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    [notes removeAllObjects];
    NSDictionary *keyPair = @{@"note": @"1"};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/note" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger noteNum = 0;
    if(jsonData != NULL)
    {
        noteNum = [jsonData count];
        
        NSLog(@"Note Number: %lu", (unsigned long)noteNum);
    }
    
    for(int i = 0; i < noteNum; i++)
    {
        tableData *note = [tableData new];
        note.tableTopic = [jsonData objectAtIndex:i][@"user"];
        note.tableContent = [jsonData objectAtIndex:i][@"topic"];
        note.tableImage = [jsonData objectAtIndex:i][@"image"];
        
        [notes addObject:note];
        
    }
    
    [super viewWillAppear:animated];

}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    // check if searchDisplayController still active..
    if ([search isActive]) {
        [search setActive:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == search.searchResultsTableView) {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"tableContent or tableTopic contains[c] %@", search.searchBar.text];
        searchResults = [notes filteredArrayUsingPredicate:resultPredicate];
        return [searchResults count];
        
    } else {
        return [notes count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    tableData *note;
    if (tableView == search.searchResultsTableView) {
        note = [searchResults objectAtIndex:indexPath.row];
    } else {
        note = [notes objectAtIndex:indexPath.row];
    }
    
    CGSize newSize = CGSizeMake(64, 64);
    NSString *imageUrlString = [note tableImage];
    
    UIImage *cachedImage = [self.imageCache objectForKey:imageUrlString];
    if (cachedImage) {
        cell.imageView.image = cachedImage;
    } else {
        // you'll want to initialize the image with some blank image as a placeholder
        
        cell.imageView.image = [ImageScaler imageResize:[UIImage imageNamed:@"image1.jpg"] andResizeTo:newSize];
        
        // now download in the image in the background
        
        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = [NSURL URLWithString:imageUrlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [ImageScaler imageResize:[UIImage imageWithData:imageData] andResizeTo:newSize];
            else
                image = [ImageScaler imageResize:[UIImage imageNamed:@"default.jpg"] andResizeTo:newSize];
            
            if (image) {
                
                [self.imageCache setObject:image forKey:imageUrlString];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imageView.image = image;
                }];
            }
        }];
    }
    
    
    cell.textLabel.text = [note tableTopic];
    cell.detailTextLabel.numberOfLines = 2000;
    if([[note tableContent] length] >= 100)
        cell.detailTextLabel.text = [[note tableContent] substringToIndex:100];
    else
        cell.detailTextLabel.text = [note tableContent];
    cell.tag = indexPath.row;
    return cell;
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    NoteDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];
    
    detailView.hidesBottomBarWhenPushed = YES;
    
    tableData *note;
    if (search.active)
    {
        note = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        note = [notes objectAtIndex:indexPath.row];
    }
    
    detailView.text = [note tableContent];
    detailView.image = [note tableImage];
    
    [[self navigationController] pushViewController:detailView animated:YES];
}


@end
