//
//  SiteViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SiteViewController.h"
#import "ExpandHeader.h"

@interface SiteViewController () <UIScrollViewDelegate>

@end

@implementation SiteViewController{
    ExpandHeader *_header;
    __weak IBOutlet UITableView *_tableView;
    __weak UIImageView *_expandView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.textLabel setText:[NSString  stringWithFormat:@"this is row :%ld",(long)indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

@end
