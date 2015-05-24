//
//  EventDetailsViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "siteData.h"
#import <GoogleMaps/GoogleMaps.h>

@interface EventDetailsViewController : UIViewController <GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSString *topicName;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *_tableView;
@property (nonatomic, strong) GMSMapView * mapView;
@property siteData *siteInfo;

@end
