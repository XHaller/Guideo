//
//  SiteViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SiteViewController.h"
#import "SiteDetailsViewController.h"
#import "ExploreViewController.h"
#import "MapViewController.h"
#import "ExpandHeader.h"
#import "ImageScaler.h"
#import "SearchDisplayController.h"
#import "tableData.h"
#import "DataTransfer.h"

@interface SiteViewController () <UIScrollViewDelegate>
{
    NSString *labelText;
    UIColor *labelColor;
    SearchDisplayController *search;
}
@end

@implementation SiteViewController{
    ExpandHeader *_header;
    __weak IBOutlet UITableView *_tableView;
    __weak UIImageView *_expandView;
}

@synthesize sites;
@synthesize searchResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    labelText = @"Interested";
    labelColor = [UIColor orangeColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Sites";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0]];
   
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextColor,[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], UITextAttributeFont, nil]];
    
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    UIImage *exploreButtonImage = [[UIImage imageNamed:@"explore.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    UIBarButtonItem *exploreItem = [[UIBarButtonItem new] initWithImage:exploreButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(exploreView)];
    
    UIImage *mapButtonImage = [[UIImage imageNamed:@"map.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    UIBarButtonItem *mapItem = [[UIBarButtonItem new] initWithImage:mapButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(mapView)];
    NSArray *itemsArr1 = @[exploreItem];
    NSArray *itemsArr2 = @[mapItem];
    self.navigationItem.leftBarButtonItems = itemsArr1;
    self.navigationItem.rightBarButtonItems = itemsArr2;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    sites = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];
    
    
    NSDictionary *keyPair = @{@"event": @"1"};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/site" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger siteNum = 0;
    if(jsonData != NULL)
    {
        siteNum = [jsonData count];
        
        NSLog(@"Event Number: %lu", (unsigned long)siteNum);
    }
    
    for(int i = 0; i < siteNum; i++)
    {
        tableData *site = [tableData new];
        site.tableTopic = [jsonData objectAtIndex:i][@"topic"];
        site.tableContent = [jsonData objectAtIndex:i][@"content"];
        site.tableImage = [jsonData objectAtIndex:i][@"image"];
        
        [sites addObject:site];
        
    }

    
    
    
//    tableData *site1 = [tableData new];
//    site1.tableTopic = @"Statue of Liberty";
//    site1.tableContent = @"The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. ";
//    site1.tableImage = @"image1.jpg";
//    
//    [sites addObject:site1];
//    
//    tableData *site2 = [tableData new];
//    site2.tableTopic = @"Metropolitan Museum of Art";
//    site2.tableContent = @"The Metropolitan Museum of Art (colloquially The Met), located in New York City, is the largest art museum in the United States and one of the ten largest in the world.";
//    site2.tableImage = @"image2.jpg";
//    
//    [sites addObject:site2];
//    
//    tableData *site3 = [tableData new];
//    site3.tableTopic = @"Central Park";
//    site3.tableContent = @"Central Park is an urban park in the central part of the borough of Manhattan, New York City.";
//    site3.tableImage = @"image3.jpg";
//    
//    [sites addObject:site3];
//    
//    tableData *site4 = [tableData new];
//    site4.tableTopic = @"Empire State Building";
//    site4.tableContent = @"The Empire State Building is a 102-story skyscraper located in Midtown Manhattan, New York City, on Fifth Avenue between West 33rd and 34th Streets.";
//    site4.tableImage = @"image4.jpg";
//    
//    [sites addObject:site4];
//    
//    tableData *site5 = [tableData new];
//    site5.tableTopic = @"Ellis Island";
//    site5.tableContent = @"Ellis Island is an island that is located in Upper New York Bay in the Port of New York and New Jersey, United States Of America.";
//    site5.tableImage = @"image5.jpg";
//    
//    [sites addObject:site5];
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    CGSize newSize = CGSizeMake(self.view.frame.size.width, 180);
    [imageView setImage:[ImageScaler imageResize:[UIImage imageNamed:@"header1"] andResizeTo:newSize]];
    
    _header = [ExpandHeader expandWithScrollView:_tableView expandView:imageView];
    
    UISearchBar *mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    [self.view addSubview:mySearchBar];

    mySearchBar.barTintColor = [UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0];
    mySearchBar.tintColor = [UIColor whiteColor];
    mySearchBar.placeholder = @"Search Sites";
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
    
    
    
  /*
    search.searchBar.barTintColor = [UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0];
    
    search.searchBar.tintColor = [UIColor whiteColor];
    
    search.searchBar.placeholder = @"Search Sites";
    search.searchBar.showsScopeBar = NO;
    
    for (UIView* subview in [[search.searchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            [textField setBackgroundColor:[UIColor colorWithRed:96/255.0 green:215/255.0 blue:255/255.0 alpha:0.3]];
        }
    }*/
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // check if searchDisplayController still active..
    if ([search isActive]) {
        [search setActive:NO];
    }
    self.navigationController.navigationBar.translucent = YES;

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
        searchResults = [sites filteredArrayUsingPredicate:resultPredicate];
        return [searchResults count];
        
    } else {
        return [sites count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        [cell setRightUtilityButtons:[self rightButtons:labelText buttonColor:labelColor] WithButtonWidth:108.0f];
        cell.delegate = self;
    }
    
    if(cell.interested)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    tableData *site;
    if (tableView == search.searchResultsTableView) {
        site = [searchResults objectAtIndex:indexPath.row];
    } else {
        site = [sites objectAtIndex:indexPath.row];
    }
    
    CGSize newSize = CGSizeMake(64, 64);
    NSURL *imageURL = [NSURL URLWithString:[site tableImage]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    cell.imageView.image = [ImageScaler imageResize:[UIImage imageWithData:imageData] andResizeTo:newSize];
    cell.textLabel.text = [site tableTopic];
    cell.detailTextLabel.numberOfLines = 2000;
    cell.detailTextLabel.text = [site tableContent];
    cell.tag = indexPath.row;
    
    return cell;
}



- (NSArray *)rightButtons:(NSString *) buttonTitle buttonColor:(UIColor*) color
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:color title:buttonTitle];
    
    return rightUtilityButtons;
}



- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    SiteDetailsViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"SiteDetailsViewController"];
    
    detailView.hidesBottomBarWhenPushed = YES;
    
    tableData *site;
    if (search.active)
    {
        site = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        site = [sites objectAtIndex:indexPath.row];
    }
    
    detailView.topicName = [site tableTopic];
    
    [[self navigationController] pushViewController:detailView animated:YES];
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void)exploreView
{
    ExploreViewController *exploreController=[self.storyboard instantiateViewControllerWithIdentifier:@"ExploreViewController"];
    exploreController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:exploreController animated:YES];
}

-(void)mapView
{
    MapViewController *mapController=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:mapController animated:YES];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    cell.interested = !cell.interested;
    [_tableView reloadData];
    
    if(cell.interested)
    {
        labelText = @"Bored";
        labelColor = [UIColor greenColor];
    }
    else
    {
        labelText = @"Interested";
        labelColor = [UIColor orangeColor];
    }
    [cell setRightUtilityButtons:[self rightButtons:labelText buttonColor:labelColor] WithButtonWidth:108.0f];
    
    
    
}
//- (void)tableView:(UITableView *)tableView prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    SiteDetailsViewController *detailView = [[SiteDetailsViewController alloc]init];
//    detailView = [segue destinationViewController];
//    NSIndexPath *path = [tableView indexPathForSelectedRow];
//    NSString *topic = [tableTopic objectAtIndex:path.row];
//    detailView.topicName = topic;
//    
//}

@end
