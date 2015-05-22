//
//  EventDetailsViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "EventDetailsViewController.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

@synthesize scrollView, _tableView, mapView;
@synthesize topicName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = topicName;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,210,self.view.frame.size.width-20,300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [scrollView addSubview:_tableView];
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(10,10,self.view.frame.size.width-20,200) camera:nil];
    
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    double latitude = 40.783333;
    double longitude = -73.966667;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:12];
    mapView.camera = camera;
    
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title = @"Central Park";
    marker.snippet = @"The biggest park in the city.";
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
    
    switch(indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Name:";
            break;
        case 1:
            cell.textLabel.text = @"Address:";
            break;
        case 2:
            cell.textLabel.text = @"Popularity:";
            break;
        case 3:
            cell.textLabel.text = @"Price:";
            break;
        case 4:
            cell.textLabel.text = @"Open Time:   Close Time:";
            break;
        case 5:
            cell.textLabel.text = @"Recommending Trip Time:";
            break;
        case 6:
            cell.textLabel.text = @"Phone:";
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    cell.detailTextLabel.numberOfLines = 200;
    cell.detailTextLabel.text = @"";
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
