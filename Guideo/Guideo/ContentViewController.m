//
//  ContentViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

@synthesize scrollView, _tableView, mapView, siteInfo, contentString, isBase;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if(isBase == NO)
    {
        UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(10,10,self.view.frame.size.width-20,430)];
        [contentView setText:contentString];
        contentView.textColor = [UIColor blackColor];
        contentView.font = [UIFont systemFontOfSize:15];
        [contentView setBackgroundColor:[UIColor clearColor]];
        contentView.editable = NO;
        contentView.scrollEnabled = YES;
        contentView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        contentView.layer.borderWidth= 2.0f;
        [scrollView addSubview:contentView];
    }
    else
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,210,self.view.frame.size.width-20,300)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [scrollView addSubview:_tableView];
        
        mapView = [GMSMapView mapWithFrame:CGRectMake(10,10,self.view.frame.size.width-20,200) camera:nil];
        
        mapView.myLocationEnabled = YES;
        mapView.delegate = self;
        double latitude = siteInfo.siteLatitude;
        double longitude = siteInfo.siteLongitude;
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                longitude:longitude
                                                                     zoom:12];
        mapView.camera = camera;
        
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(latitude, longitude);
        marker.title = siteInfo.siteName;
        marker.snippet = [@"Recommendation Trip Time: " stringByAppendingString: siteInfo.siteTripTime];
        marker.map = mapView;
        [scrollView addSubview:mapView];
    }
    scrollView.scrollEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row == 0)
    {
        cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    }
    else
    {
        cell.textLabel.font = [UIFont fontWithName:@"ArialHebrew" size:15];
    }
    
   // NSLog(@"%@", [@"Opening Time:" stringByAppendingString:siteInfo.siteOpen]);
    
    cell.detailTextLabel.numberOfLines = 200;
    switch(indexPath.row)
    {
        case 0:
            cell.textLabel.text = siteInfo.siteName;
            cell.detailTextLabel.text = @"";
            break;
        case 1:
            cell.textLabel.text = @"Popularity: ";
            cell.detailTextLabel.text = siteInfo.sitePopularity;
            break;
        case 2:
            cell.textLabel.text = @"Opening Time:";
            cell.detailTextLabel.text = siteInfo.siteOpen;
            break;
        case 3:
            cell.textLabel.text = @"Address: ";
            cell.detailTextLabel.text = siteInfo.siteAddress;
            break;
        case 4:
            cell.textLabel.text = @"Price: ";
            cell.detailTextLabel.text = siteInfo.sitePrice;
            break;
        case 5:
            cell.textLabel.text = @"Recommending Trip Time: ";
            cell.detailTextLabel.text = siteInfo.siteTripTime;
            break;
        case 6:
            cell.textLabel.text = @"Contact: ";
            cell.detailTextLabel.text = siteInfo.sitePhone;
            break;
        default:
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
            break;
    }
    
    cell.tag = indexPath.row;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.0f;
}


@end
