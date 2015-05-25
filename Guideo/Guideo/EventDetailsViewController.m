//
//  EventDetailsViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "siteData.h"
#import "DataTransfer.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

@synthesize scrollView, _tableView, mapView;
@synthesize topicName,siteInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = topicName;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,210,self.view.frame.size.width-20,300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [scrollView addSubview:_tableView];
    
    siteInfo = [[siteData alloc] init];
    
    
    
    NSDictionary *keyPair = @{@"event_name": topicName};
    NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/event/detail" httpMethod:@"POST" params:keyPair];
    
    siteInfo.siteName = jsonData[@"topic"];
    siteInfo.sitePhone = jsonData[@"phone"];
    siteInfo.sitePopularity = [[NSNumber numberWithDouble:(arc4random() % 10)] stringValue];
    siteInfo.siteLatitude = [jsonData[@"latitude"] doubleValue];
    siteInfo.siteLongitude = [jsonData[@"longitude"] doubleValue];
    siteInfo.sitePrice = [[NSNumber numberWithDouble:(arc4random() % 100)] stringValue];
    siteInfo.siteOpen = jsonData[@"date"];
    siteInfo.siteAddress = jsonData[@"address"];
    siteInfo.siteIntro = jsonData[@"content"];
    siteInfo.siteTripTime = jsonData[@"website"];
    
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
    marker.snippet = siteInfo.siteIntro;
    marker.map = mapView;
    [scrollView addSubview:mapView];
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
            cell.textLabel.text = @"Introduction: ";
            if([siteInfo.siteIntro length] >= 100)
                cell.detailTextLabel.text = [siteInfo.siteIntro substringToIndex:100];
            else
                cell.detailTextLabel.text = siteInfo.siteIntro;
            break;
        case 2:
            cell.textLabel.text = @"Popularity: ";
            cell.detailTextLabel.text = siteInfo.sitePopularity;
            break;
        case 3:
            cell.textLabel.text = @"Time:";
            cell.detailTextLabel.text = siteInfo.siteOpen;
            break;
        case 4:
            cell.textLabel.text = @"Address: ";
            cell.detailTextLabel.text = siteInfo.siteAddress;
            break;
        case 5:
            cell.textLabel.text = @"Contact: ";
            cell.detailTextLabel.text = [siteInfo.sitePhone stringByAppendingString:[@"\n" stringByAppendingString:siteInfo.siteTripTime]];
            break;
        case 6:
            cell.textLabel.text = @"Price: ";
            cell.detailTextLabel.text = siteInfo.sitePrice;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
