//
//  EventViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "EventViewController.h"
#import "EventDetailsViewController.h"
#import "SearchDisplayController.h"
#import "tableData.h"
#import "DataTransfer.h"
#import "ImageScaler.h"

@interface EventViewController ()
{
    SearchDisplayController *search;
}
@end

@implementation EventViewController{
    __weak IBOutlet UITableView *_tableView;
}

@synthesize events;
@synthesize searchResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Events";
    
   // [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextColor,[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], UITextAttributeFont, nil]];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    events = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];
    
    NSDictionary *keyPair = @{@"latitude": @"0", @"longitude": @"0"};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/event" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger eventNum = 0;
    if(jsonData != NULL)
    {
        eventNum = [jsonData count];
        
        NSLog(@"Event Number: %lu", (unsigned long)eventNum);
    }

    for(int i = 0; i < eventNum; i++)
    {
        tableData *event = [tableData new];
        event.tableTopic = [jsonData objectAtIndex:i][@"topic"];
        event.tableContent = [jsonData objectAtIndex:i][@"content"];
        event.tableImage = [jsonData objectAtIndex:i][@"image"];
        
        [events addObject:event];
        
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
    
    
    
//    search.searchBar.barTintColor = [UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0];
//    
//    search.searchBar.tintColor = [UIColor whiteColor];
//    for (UIView* subview in [[search.searchBar.subviews lastObject] subviews]) {
//        if ([subview isKindOfClass:[UITextField class]]) {
//            UITextField *textField = (UITextField*)subview;
//            [textField setBackgroundColor:[UIColor colorWithRed:96/255.0 green:215/255.0 blue:255/255.0 alpha:0.3]];
//        }
//    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"tableTopic contains[c] %@", search.searchBar.text];
        searchResults = [events filteredArrayUsingPredicate:resultPredicate];
        return [searchResults count];
        
    } else {
        return [events count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    tableData *event;
    if (tableView == search.searchResultsTableView) {
        event = [searchResults objectAtIndex:indexPath.row];
    } else {
        event = [events objectAtIndex:indexPath.row];
    }
    
    CGSize newSize = CGSizeMake(64, 64);
    NSURL *imageURL = [NSURL URLWithString:[event tableImage]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    cell.imageView.image = [ImageScaler imageResize:[UIImage imageWithData:imageData] andResizeTo:newSize];
    
    cell.textLabel.text = [event tableTopic];
    cell.detailTextLabel.numberOfLines = 2000;
    cell.detailTextLabel.text = [event tableContent];
    cell.tag = indexPath.row;
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    [cell.textLabel setText:[NSString  stringWithFormat:@"this is row :%ld",(long)indexPath.row]];
//    return cell;
//}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    EventDetailsViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailsViewController"];
    
    detailView.hidesBottomBarWhenPushed = YES;
    
    tableData *event;
    if (search.active)
    {
        event = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        event = [events objectAtIndex:indexPath.row];
    }
    
    detailView.topicName = [event tableTopic];
    
    [[self navigationController] pushViewController:detailView animated:YES];
}



//- (void)tableView:(UITableView *)tableView prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    eventDetailsViewController *detailView = [[eventDetailsViewController alloc]init];
//    detailView = [segue destinationViewController];
//    NSIndexPath *path = [tableView indexPathForSelectedRow];
//    NSString *topic = [tableTopic objectAtIndex:path.row];
//    detailView.topicName = topic;
//
//}

@end
