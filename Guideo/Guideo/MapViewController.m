//
//  MapViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "MapViewController.h"
#import "DirectionService.h"


@interface MapViewController ()
{
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
}

@end

@implementation MapViewController
{
    BOOL isRouting;
    UIImage *routeButtonImage;
    UIImage *noRouteButtonImage;
}

@synthesize locationManager;
@synthesize latitude;
@synthesize longitude;
@synthesize siteName;
@synthesize siteInfo;
@synthesize mapView;

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
    
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    
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
    
    CLLocation *location = [locationManager location];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:6];
    
   // NSLog(@"%f", location.coordinate.latitude);
    /*
    siteName = [[NSMutableArray alloc] init];
    siteInfo = [[NSMutableArray alloc] init];
    latitude = [[NSMutableArray alloc] init];
    longitude = [[NSMutableArray alloc] init];
    
    [siteName addObject:@"Central Park"];
    [siteName addObject:@"Msm of Metropolitan"];
    [siteName addObject:@"Empire Building"];
    [siteName addObject:@"Lincoln Center"];
    
    [siteInfo addObject:@"The biggest park in the city."];
    [siteInfo addObject:@"Good museum to go."];
    [siteInfo addObject:@"The tallest building in New York."];
    [siteInfo addObject:@"Place to enjoy music."];
    
    [latitude addObject:[NSNumber numberWithDouble:40.783333]];
    [latitude addObject:[NSNumber numberWithDouble:40.779447]];
    [latitude addObject:[NSNumber numberWithDouble:40.748433]];
    [latitude addObject:[NSNumber numberWithDouble:40.772311]];
    
    [longitude addObject:[NSNumber numberWithDouble:-73.966667]];
    [longitude addObject:[NSNumber numberWithDouble:-73.96311]];
    [longitude addObject:[NSNumber numberWithDouble:-73.985656]];
    [longitude addObject:[NSNumber numberWithDouble:-73.983403]];*/
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:41
//                                                            longitude:74
//                                                                 zoom:8];
//
    
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    location = mapView.myLocation;
    camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                         longitude:location.coordinate.longitude
                                              zoom:12];
    mapView.camera = camera;
    //NSLog(@"%lu", (unsigned long)[siteName count]);
    for(int i = 0; i < [latitude count]; i++)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue],[[longitude objectAtIndex:i] doubleValue]);
        marker.icon = [UIImage imageNamed:@"normalMark"];
        marker.title = [siteName objectAtIndex:i];
        marker.snippet = [siteInfo objectAtIndex:i];
        marker.map = mapView;
    }
    
    self.view = mapView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(250, 490, 50, 50);
    UIImage *btnImage = [UIImage imageNamed:@"userMark"];
    [button setImage:btnImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fixOnSelf) forControlEvents:UIControlEventTouchUpInside];
    
    [mapView addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    //NSLog(@"%.8f",location.coordinate.latitude);
    //NSLog(@"%.8f",location.coordinate.longitude);
    
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [mapView animateToLocation:target];
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
        
        CLLocation *location = [locationManager location];
        location = mapView.myLocation;
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [waypoints_ addObject:marker];
        NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                    location.coordinate.latitude, location.coordinate.longitude];
        [waypointStrings_ addObject:positionString];
        
        [mapView clear];
        for(int i = 0; i < [latitude count]; i++)
        {
            double markerLat = [[latitude objectAtIndex:i] doubleValue];
            double markerLon = [[longitude objectAtIndex:i] doubleValue];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(markerLat, markerLon);
            marker.icon = [UIImage imageNamed:@"interMark"];
            marker.title = [siteName objectAtIndex:i];
            marker.snippet = [siteInfo objectAtIndex:i];
            marker.map = mapView;
            
            [waypoints_ addObject:marker];
            NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                    markerLat, markerLon];
            NSLog(@"%@",positionString);
            [waypointStrings_ addObject:positionString];
        }

        if([waypoints_ count]>1)
        {
            NSString *sensor = @"false";
            NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                                   nil];
            NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
            NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                              forKeys:keys];
            DirectionService *mds=[[DirectionService alloc] init];
            SEL selector = @selector(addDirections:);
            [mds setDirectionsQuery:query
                       withSelector:selector
                       withDelegate:self];
        }

        
        
//        [mapView clear];
//        for(int i = 0; i < [latitude count]; i++)
//        {
//            GMSMarker *marker = [[GMSMarker alloc] init];
//            marker.position = CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue],[[longitude objectAtIndex:i] doubleValue]);
//            marker.icon = [UIImage imageNamed:@"interMark"];
//            marker.title = [siteName objectAtIndex:i];
//            marker.snippet = [siteInfo objectAtIndex:i];
//            marker.map = mapView;
//        }
//        
//        GMSMutablePath *path = [GMSMutablePath path];
//        for(int i = 0; i < [latitude count]; i++)
//        {
//            [path addCoordinate:CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue],    [[longitude objectAtIndex:i] doubleValue])];
//        }
//    
//        GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//        rectangle.strokeWidth = 2.f;
//        rectangle.map = mapView;
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
            marker.icon = [UIImage imageNamed:@"normalMark"];
            marker.title = [siteName objectAtIndex:i];
            marker.snippet = [siteInfo objectAtIndex:i];
            marker.map = mapView;
        }
        [waypoints_ removeAllObjects];
        [waypointStrings_ removeAllObjects];
    }
}

- (void)addDirections:(NSDictionary *)json {
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 4.0f;
    polyline.strokeColor = [UIColor redColor];
    polyline.map = mapView;
}


- (void) fixOnSelf
{
    CLLocation *location = [locationManager location];
    location = mapView.myLocation;
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
//                                         longitude:location.coordinate.longitude
//                                              zoom:12];
    CLLocationCoordinate2D target =
    CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    [mapView animateToLocation:target];
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
