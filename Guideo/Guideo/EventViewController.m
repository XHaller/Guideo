//
//  EventViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "EventViewController.h"
#import "EventDetailsViewController.h"
#import "tableData.h"

@interface EventViewController ()

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
    
    tableData *event1 = [tableData new];
    event1.tableTopic = @"One day cruise";
    event1.tableContent = @"The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. ";
    event1.tableImage = @"image1.jpg";
    
    [events addObject:event1];
    
    tableData *event2 = [tableData new];
    event2.tableTopic = @"Discount ticket!";
    event2.tableContent = @"The Metropolitan Museum of Art (colloquially The Met), located in New York City, is the largest art museum in the United States and one of the ten largest in the world.";
    event2.tableImage = @"image2.jpg";
    
    [events addObject:event2];
    
    tableData *event3 = [tableData new];
    event3.tableTopic = @"Picnic at noon";
    event3.tableContent = @"Central Park is an urban park in the central part of the borough of Manhattan, New York City.";
    event3.tableImage = @"image3.jpg";
    
    [events addObject:event3];
    
    tableData *event4 = [tableData new];
    event4.tableTopic = @"Climb to the sky";
    event4.tableContent = @"The Empire State Building is a 102-story skyscraper located in Midtown Manhattan, New York City, on Fifth Avenue between West 33rd and 34th Streets.";
    event4.tableImage = @"image4.jpg";
    
    [events addObject:event4];
    
    tableData *event5 = [tableData new];
    event5.tableTopic = @"Island Sale!";
    event5.tableContent = @"Ellis Island is an island that is located in Upper New York Bay in the Port of New York and New Jersey, United States Of America.";
    event5.tableImage = @"image5.jpg";
    
    [events addObject:event5];
    
    self.searchDisplayController.searchBar.barTintColor = [UIColor colorWithRed:176/255.0 green:215/255.0 blue:255/255.0 alpha:1.0];
    
    self.searchDisplayController.searchBar.tintColor = [UIColor whiteColor];
    for (UIView* subview in [[self.searchDisplayController.searchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            [textField setBackgroundColor:[UIColor colorWithRed:96/255.0 green:215/255.0 blue:255/255.0 alpha:0.3]];
        }
    }

    
    
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
    if ([self.searchDisplayController isActive]) {
        [self.searchDisplayController setActive:NO];
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        event = [searchResults objectAtIndex:indexPath.row];
    } else {
        event = [events objectAtIndex:indexPath.row];
    }
    
    cell.imageView.image = [UIImage imageNamed:[event tableImage]];
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
    if (self.searchDisplayController.active)
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

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"tableTopic contains[c] %@", searchText];
    searchResults = [events filteredArrayUsingPredicate:resultPredicate];
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
