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
#import "userData.h"
#import "DataTransfer.h"

@interface SiteViewController () <UIScrollViewDelegate>
{
    SearchDisplayController *search;
    userData *user;
    NSArray *interestingString;
    NSMutableSet *tempset;
    NSMutableArray *ifInterested;
    CLLocation * location;
}
@end

@implementation SiteViewController{
    ExpandHeader *_header;
    __weak IBOutlet UITableView *_tableView;
    __weak UIImageView *_expandView;
}

@synthesize sites;
@synthesize searchResults, finalShowSites;
@synthesize interestedSites, imageCache, imageDownloadingQueue;
@synthesize locationManager, mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    
    user = [userData sharedSingletonClass];
    
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
    UIBarButtonItem *mapItem = [[UIBarButtonItem new] initWithImage:mapButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(mappingView)];
    NSArray *itemsArr1 = @[exploreItem];
    NSArray *itemsArr2 = @[mapItem];
    self.navigationItem.leftBarButtonItems = itemsArr1;
    self.navigationItem.rightBarButtonItems = itemsArr2;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 500;
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
    
    CLLocation *location = [locationManager location];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    location = mapView.myLocation;
    
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    sites = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];
    interestedSites = [[NSMutableSet alloc] init];
    ifInterested = [[NSMutableArray alloc] init];
    finalShowSites = [[NSMutableArray alloc] init];
    
    NSDictionary *keyPair = @{@"latitude": [[NSNumber numberWithDouble:location.coordinate.latitude]  stringValue], @"longitude": [[NSNumber numberWithDouble:location.coordinate.longitude]  stringValue]};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/site" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger siteNum = 0;
    if(jsonData != NULL)
    {
        siteNum = [jsonData count];
        
        NSLog(@"Site Number: %lu", (unsigned long)siteNum);
    }
    
    for(int i = 0; i < siteNum; i++)
    {
        tableData *site = [tableData new];
        site.tableTopic = [jsonData objectAtIndex:i][@"topic"];
        site.tableContent = [jsonData objectAtIndex:i][@"content"];
        site.tableImage = [jsonData objectAtIndex:i][@"image"];
        site.latitude = [jsonData objectAtIndex:i][@"latitude"];
        site.longitude = [jsonData objectAtIndex:i][@"longitude"];
        [sites addObject:site];
        [ifInterested addObject:[NSNumber numberWithBool:NO]];
    }
    
    NSString* username = user.userName;
    //NSLog(@"UserName: %@", username);
    NSDictionary *keyPair2 = @{@"username": username};
    NSDictionary *jsonData2 = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/interest/get" httpMethod:@"POST" params:keyPair2];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    interestingString = [jsonData2[@"name"] componentsSeparatedByString:@","];
    tempset = [NSMutableSet setWithArray:interestingString];
    
  /*
    tableData *site1 = [tableData new];
    site1.tableTopic = @"Statue of Liberty";
    site1.tableContent = @"The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. ";
    site1.tableImage = @"image1.jpg";
    site1.latitude = @"40.689167";
    site1.longitude= @"-74.044444";
    
    
    [sites addObject:site1];
    
    tableData *site2 = [tableData new];
    site2.tableTopic = @"The Metropolitan Museum of Art";
    site2.tableContent = @"The Metropolitan Museum of Art (colloquially The Met), located in New York City, is the largest art museum in the United States and one of the ten largest in the world.";
    site2.tableImage = @"image2.jpg";
    site2.latitude = @"40.779447";
    site2.longitude= @"-73.96311";
    
    [sites addObject:site2];
    
    tableData *site3 = [tableData new];
    site3.tableTopic = @"Central Park";
    site3.tableContent = @"Central Park is an urban park in the central part of the borough of Manhattan, New York City.";
    site3.tableImage = @"image3.jpg";
    site3.latitude = @"40.783333";
    site3.longitude= @"-73.966667";
    
    [sites addObject:site3];
    
    tableData *site4 = [tableData new];
    site4.tableTopic = @"Empire State Building";
    site4.tableContent = @"The Empire State Building is a 102-story skyscraper located in Midtown Manhattan, New York City, on Fifth Avenue between West 33rd and 34th Streets.";
    site4.tableImage = @"image4.jpg";
    site4.latitude = @"40.748433";
    site4.longitude= @"-73.985656";
    
    [sites addObject:site4];
    
    tableData *site5 = [tableData new];
    site5.tableTopic = @"Lincoln Center";
    site5.tableContent = @"Lincoln Center for the Performing Arts is a 16.3-acre (6.6-hectare) complex of buildings in the Lincoln Square neighborhood of Manhattan in New York City. Jed Bernstein began as president in 2014.";
    site5.tableImage = @"image5.jpg";
    site5.latitude = @"40.772311";
    site5.longitude= @"-73.983403";
    
    [sites addObject:site5];
   */
   
    
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

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    //NSLog(@"%.8f",location.coordinate.latitude);
    //NSLog(@"%.8f",location.coordinate.longitude);
    
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [mapView animateToLocation:target];
    }
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
    
    NSString *cellIdentifier = @"Cell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        NSString *labelText = @"Interested";
        UIColor *labelColor = [UIColor orangeColor];
        
        [cell setRightUtilityButtons:[self rightButtons:labelText buttonColor:labelColor] WithButtonWidth:108.0f];
        cell.delegate = self;
    }
    
    
    tableData *site;
    if (tableView == search.searchResultsTableView) {
        site = [searchResults objectAtIndex:indexPath.row];
    } else {
        site = [sites objectAtIndex:indexPath.row];
    }

    
    CGSize newSize = CGSizeMake(64, 64);
    NSString *imageUrlString = [site tableImage];

    UIImage *cachedImage = [self.imageCache objectForKey:imageUrlString];
    if (cachedImage) {
        cell.imageView.image = cachedImage;
    } else {
        
        cell.imageView.image = [ImageScaler imageResize:[UIImage imageNamed:@"image1.jpg"] andResizeTo:newSize];
        
        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = [NSURL URLWithString:imageUrlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [ImageScaler imageResize:[UIImage imageWithData:imageData] andResizeTo:newSize];
            
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
    
    
    if([tempset containsObject:[site tableTopic]])
    {
        //cell.interested = YES;
        [ifInterested replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        NSString * labelText = @"Bored";
        UIColor *labelColor = [UIColor greenColor];
        [cell setRightUtilityButtons:[self rightButtons:labelText buttonColor:labelColor] WithButtonWidth:108.0f];
        [interestedSites addObject:[site tableTopic]];
        [tempset removeObject:[site tableTopic]];
    }
    
    
    cell.textLabel.text = [site tableTopic];
    cell.detailTextLabel.numberOfLines = 2000;
    if([[site tableContent] length] >= 100)
        cell.detailTextLabel.text = [[site tableContent] substringToIndex:100];
    else
        cell.detailTextLabel.text = [site tableContent];
    cell.tag = indexPath.row;
    
    if([[ifInterested objectAtIndex:indexPath.row] boolValue])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
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

-(void) mappingView
{
    MapViewController *mapController=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapController.hidesBottomBarWhenPushed = YES;
    
    mapController.siteName = [[NSMutableArray alloc] init];
    mapController.siteInfo = [[NSMutableArray alloc] init];
    mapController.latitude = [[NSMutableArray alloc] init];
    mapController.longitude = [[NSMutableArray alloc] init];
    
    NSMutableString *sitelist = [NSMutableString stringWithString:@""];
    
    NSArray *interested = [interestedSites allObjects];
    
    //NSLog(@"interest sites: %@", [interested objectAtIndex:0]);
    for(int i = 0; i < [interested count]; i++)
    {
        [sitelist appendString:[interested objectAtIndex:i]];
        [sitelist appendString:@","];
        //NSLog(@"interest sites: %@", sitelist);
    }
    
     if ([sitelist length] > 0)
     {
         [sitelist deleteCharactersInRange:NSMakeRange([sitelist length]-1, 1)];
     }
    
    //NSLog(@"interest sites: %@", sitelist);
    
    CLLocation* location = mapView.myLocation;
    
    NSLog(@"%.8f",location.coordinate.latitude);
    NSLog(@"%.8f",location.coordinate.longitude);
    
    NSDictionary *keyPair = @{@"sitename": sitelist, @"latitude": [[NSNumber numberWithDouble:location.coordinate.latitude]  stringValue], @"longitude": [[NSNumber numberWithDouble:location.coordinate.longitude]  stringValue]};
    NSArray *jsonData = [DataTransfer requestArrayWithURL:@"http://52.6.223.152:80/site/map" httpMethod:@"POST" params:keyPair];
    
    //NSString *word = [jsonData objectAtIndex:0][@"topic"];
    //NSLog(@"jsonData: %@\n\n",word);
    
    NSUInteger siteNum = 0;
    if(jsonData != NULL)
    {
        siteNum = [jsonData count];
        
        NSLog(@"Site Number: %lu", (unsigned long)siteNum);
    }
    
    for(int i = 0; i < siteNum; i++)
    {
        [mapController.siteName addObject:[jsonData objectAtIndex:i][@"topic"]];
        if([[jsonData objectAtIndex:i][@"content"] length] >= 100)
            [mapController.siteInfo addObject:[[jsonData objectAtIndex:i][@"content"] substringToIndex:100]];
        else
            [mapController.siteInfo addObject:[jsonData objectAtIndex:i][@"content"]];
        [mapController.latitude addObject:[NSNumber numberWithDouble:[[jsonData objectAtIndex:i][@"latitude"] doubleValue]]];
        // NSLog(@"%d %f", i, [[tempData latitude] doubleValue]);
        [mapController.longitude addObject:[NSNumber numberWithDouble:[[jsonData objectAtIndex:i][@"longitude"] doubleValue]]];
        // NSLog(@"%d %f", i, [[tempData longitude] doubleValue]);
    }
    
    [[self navigationController] pushViewController:mapController animated:YES];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    [ifInterested replaceObjectAtIndex:cell.tag withObject:[NSNumber numberWithBool:![[ifInterested objectAtIndex:cell.tag] boolValue]]];

    
    [_tableView reloadData];
    
    NSDictionary *keyPair;
    NSString *labelText;
    UIColor *labelColor;
    NSString* username = user.userName;
    if([[ifInterested objectAtIndex:cell.tag] boolValue])
    {
        labelText = @"Bored";
        labelColor = [UIColor greenColor];
        [interestedSites addObject:[[sites objectAtIndex:cell.tag] tableTopic]];
        
        //NSArray *siteArray = [interestedSites allObjects];
        //NSLog(@"index: %@", [[siteArray objectAtIndex:0] tableTopic]);
        keyPair = @{@"username": username, @"sitename": [[sites objectAtIndex:cell.tag] tableTopic], @"interested": @"1"};
    }
    else
    {
        labelText = @"Interested";
        labelColor = [UIColor orangeColor];
        [interestedSites removeObject:[[sites objectAtIndex:cell.tag] tableTopic]];
       // NSLog(@"index: %lu", (unsigned long)[interestedSites count]);
        keyPair = @{@"username": username, @"sitename": [[sites objectAtIndex:cell.tag] tableTopic], @"interested": @"0"};
    }
    [cell setRightUtilityButtons:[self rightButtons:labelText buttonColor:labelColor] WithButtonWidth:108.0f];
    
    
    [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/interest" httpMethod:@"POST" params:keyPair];
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
