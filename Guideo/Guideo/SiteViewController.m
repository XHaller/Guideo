//
//  SiteViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SiteViewController.h"
#import "SiteDetailsViewController.h"
#import "ExpandHeader.h"

@interface SiteViewController () <UIScrollViewDelegate>

@end

@implementation SiteViewController{
    ExpandHeader *_header;
    __weak IBOutlet UITableView *_tableView;
    __weak UIImageView *_expandView;
}

@synthesize tableTopic;
@synthesize tableContent;
@synthesize tableImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableTopic = [[NSMutableArray alloc] init];
    tableContent = [[NSMutableArray alloc] init];
    tableImage = [[NSMutableArray alloc] init];
    
    [tableTopic addObject:@"Statue of Liberty"];
    [tableContent addObject:@"The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. "];
    
    [tableTopic addObject:@"Metropolitan Museum of Art"];
    [tableContent addObject:@"The Metropolitan Museum of Art (colloquially The Met), located in New York City, is the largest art museum in the United States and one of the ten largest in the world."];
    
    [tableTopic addObject:@"Central Park"];
    [tableContent addObject:@"Central Park is an urban park in the central part of the borough of Manhattan, New York City."];
    
    [tableTopic addObject:@"Empire State Building"];
    [tableContent addObject:@"The Empire State Building is a 102-story skyscraper located in Midtown Manhattan, New York City, on Fifth Avenue between West 33rd and 34th Streets."];
    
    [tableTopic addObject:@"Ellis Island"];
    [tableContent addObject:@"Ellis Island is an island that is located in Upper New York Bay in the Port of New York and New Jersey, United States Of America."];
    
    
    for(int i = 0; i < 5; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        [tableImage addObject:image];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 180)];
    [imageView setImage:[UIImage imageNamed:@"header1"]];
    
    _header = [ExpandHeader expandWithScrollView:_tableView expandView:imageView];
    
    // Do any additional setup after loading the view, typically from a nib.
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
    return tableTopic.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [tableImage objectAtIndex:indexPath.row];
    cell.textLabel.text = [tableTopic objectAtIndex: indexPath.row];
    cell.detailTextLabel.numberOfLines = 2000;
    cell.detailTextLabel.text = [tableContent objectAtIndex:indexPath.row];
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
    SiteDetailsViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"SiteDetailsViewController"];
    
    detailView.topicName = [tableTopic objectAtIndex:indexPath.row];
    
    [[self navigationController] pushViewController:detailView animated:YES];
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
