//
//  ContentViewController.h
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
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
