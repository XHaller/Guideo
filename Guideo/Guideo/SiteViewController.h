//
//  SiteViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface SiteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate, GMSMapViewDelegate, CLLocationManagerDelegate>

@property NSMutableArray *sites;
@property NSMutableSet* sitesSet;
@property NSMutableArray *searchResults;
@property NSMutableArray *finalShowSites;
@property NSMutableSet *interestedSites;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GMSMapView *mapView;

@end