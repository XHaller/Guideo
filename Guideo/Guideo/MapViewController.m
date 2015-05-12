//
//  MapViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController
{
    GMSMapView *mapView;
    BOOL isRouting;
    UIImage *routeButtonImage;
    UIImage *noRouteButtonImage;
}

@synthesize locationManager;
@synthesize latitude;
@synthesize longitude;
@synthesize siteName;
@synthesize siteInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Google Map";
    isRouting = NO;
    
    routeButtonImage = [[UIImage imageNamed:@"routing.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    noRouteButtonImage = [[UIImage imageNamed:@"noRouting.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    UIBarButtonItem *routeItem = [[UIBarButtonItem new] initWithImage:routeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(showRoute)];
    
    NSArray *itemsArr = @[routeItem];
    self.navigationItem.rightBarButtonItems = itemsArr;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    if (locationManager == nil)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 500;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
    
//    mapView.myLocationEnabled = YES;
//    CLLocation *location = mapView.myLocation;
//    
//    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
//                                                            longitude:location.coordinate.longitude
//                                                                 zoom:6];
    
    siteName = [[NSMutableArray alloc] init];
    siteInfo = [[NSMutableArray alloc] init];
    latitude = [[NSMutableArray alloc] init];
    longitude = [[NSMutableArray alloc] init];
    
    [siteName addObject:@"Statue of Liberty"];
    [siteName addObject:@"Msm of Metropolitan"];
    [siteName addObject:@"Ellis Islands"];
    [siteName addObject:@"Empire Building"];
    
    [siteInfo addObject:@"A woman with freedom"];
    [siteInfo addObject:@"Good museum to go"];
    [siteInfo addObject:@"Place to keep foreigners outside"];
    [siteInfo addObject:@"The tallest building in New York"];
    
    [latitude addObject:[NSNumber numberWithDouble:40.7992]];
    [latitude addObject:[NSNumber numberWithDouble:41.3294]];
    [latitude addObject:[NSNumber numberWithDouble:41.2887]];
    [latitude addObject:[NSNumber numberWithDouble:40.8563]];
    
    [longitude addObject:[NSNumber numberWithDouble:73.8744]];
    [longitude addObject:[NSNumber numberWithDouble:73.9657]];
    [longitude addObject:[NSNumber numberWithDouble:74.2133]];
    [longitude addObject:[NSNumber numberWithDouble:74.5274]];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:41
                                                            longitude:74
                                                                 zoom:8];

    
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    for(int i = 0; i < [latitude count]; i++)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue],[[longitude objectAtIndex:i] doubleValue]);
        marker.title = [siteName objectAtIndex:i];
        marker.snippet = [siteInfo objectAtIndex:i];
        marker.map = mapView;
    }
    
    self.view = mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // check if searchDisplayController still active..
    if ([self.searchDisplayController isActive]) {
        [self.searchDisplayController setActive:NO];
    }
    
   // CLLocation *location = locationManager.location;
   // NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // Update your marker on your map using location.coordinate.latitude
        //and location.coordinate.longitude);
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [mapView animateToLocation:target];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

- (void) showRoute
{
    if(!isRouting)
    {
        isRouting = YES;
        UIBarButtonItem *routeItem = [[UIBarButtonItem new] initWithImage:noRouteButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(showRoute)];
        
        NSArray *itemsArr = @[routeItem];
        self.navigationItem.rightBarButtonItems = itemsArr;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        
        GMSMutablePath *path = [GMSMutablePath path];
        for(int i = 0; i < [latitude count]; i++)
        {
            [path addCoordinate:CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue],    [[longitude objectAtIndex:i] doubleValue])];
        }
    
        GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
        rectangle.strokeWidth = 2.f;
        rectangle.map = mapView;
    }
    else
    {
        isRouting = NO;
        UIBarButtonItem *routeItem = [[UIBarButtonItem new] initWithImage:routeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(showRoute)];
        
        NSArray *itemsArr = @[routeItem];
        self.navigationItem.rightBarButtonItems = itemsArr;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        
        [mapView clear];
        for(int i = 0; i < [latitude count]; i++)
        {
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue],[[longitude objectAtIndex:i] doubleValue]);
            marker.title = [siteName objectAtIndex:i];
            marker.snippet = [siteInfo objectAtIndex:i];
            marker.map = mapView;
        }
        
    }
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