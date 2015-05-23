//
//  MapViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) NSMutableArray *latitude;
@property (nonatomic, strong) NSMutableArray *longitude;
@property (nonatomic, strong) NSMutableArray *siteName;
@property (nonatomic, strong) NSMutableArray *siteInfo;

@end
