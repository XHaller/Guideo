//
//  MapViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate> {

     CLLocationManager *locationManager;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property NSMutableArray *latitude;
@property NSMutableArray *longitude;
@property NSMutableArray *siteName;
@property NSMutableArray *siteInfo;

@end
