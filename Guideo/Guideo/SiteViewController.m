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
    
    for(int i = 0; i < 5; i++)
    {
        [tableTopic addObject:@"Statue of Liberty"];
        [tableContent addObject:@"The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. "];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
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
    SiteDetailsViewController *detailView = [[SiteDetailsViewController alloc]init];
    [[self navigationController] pushViewController:detailView animated:YES];
}

@end
