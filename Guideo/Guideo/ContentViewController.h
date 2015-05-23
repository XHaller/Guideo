//
//  ContentViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "siteData.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ContentViewController : UIViewController <GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *_tableView;
@property (nonatomic, strong) GMSMapView * mapView;
@property (nonatomic, assign) BOOL isBase;
@property (nonatomic, weak) NSString *contentString;
@property siteData* siteInfo;

@end
