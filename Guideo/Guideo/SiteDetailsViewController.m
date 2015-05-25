//
//  SiteDetailsViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/15.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SiteDetailsViewController.h"
#import "ContentViewController.h"
#import "PicturesViewController.h"
#import "siteData.h"
#import "DataTransfer.h"


@interface SiteDetailsViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic) NSUInteger numberOfTabs;

@end

@implementation SiteDetailsViewController
@synthesize topicName;
@synthesize siteInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    self.title = topicName;
    
    self.dataSource = self;
    self.delegate = self;

    siteInfo = [[siteData alloc] init];
    siteInfo.siteName = topicName;
    
    
    NSDictionary *keyPair = @{@"site_name": topicName};
    NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/site/detail" httpMethod:@"POST" params:keyPair];
    
    siteInfo.sitePhone = jsonData[@"phone"];
    siteInfo.siteAddress = jsonData[@"address"];
    siteInfo.sitePopularity = [[NSNumber numberWithDouble:(arc4random() % 10)] stringValue];
    siteInfo.siteLatitude = [jsonData[@"latitude"] doubleValue];
    siteInfo.siteLongitude = [jsonData[@"longitude"] doubleValue];
    siteInfo.sitePrice = jsonData[@"fee"];
    siteInfo.siteOpen = jsonData[@"hours"];
    siteInfo.siteTripTime = jsonData[@"trip_time"];
    
    siteInfo.siteItemsName = [[NSMutableArray alloc] init];
    [siteInfo.siteItemsName addObject:@"Info"];
    [siteInfo.siteItemsName addObject:@"Basic"];
    [siteInfo.siteItemsName addObject:@"History"];
    [siteInfo.siteItemsName addObject:@"Culture"];
    [siteInfo.siteItemsName addObject:@"Artifact"];
    
    siteInfo.siteItemsContent = [[NSMutableArray alloc] init];
    [siteInfo.siteItemsContent addObject:@""];
    [siteInfo.siteItemsContent addObject:jsonData[@"basic"]];
    [siteInfo.siteItemsContent addObject:jsonData[@"history"]];
    [siteInfo.siteItemsContent addObject:jsonData[@"culture"]];
    [siteInfo.siteItemsContent addObject:jsonData[@"artifact"]];
    
    // Keeps tab bar below navigation bar on iOS 7.0+
//     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//         self.edgesForExtendedLayout = UIRectEdgeNone;
//     }
    
    self.numberOfTabs = [siteInfo.siteItemsName count];
    
    UIImage *picturesButtonImage = [[UIImage imageNamed:@"pictures.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    UIBarButtonItem *pictureItem = [[UIBarButtonItem new] initWithImage:picturesButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(pictureView)];
   
    NSArray *itemsArr = @[pictureItem];
    self.navigationItem.rightBarButtonItems = itemsArr;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters
- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
    
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.numberOfTabs;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:20.0];
    label.text = [siteInfo.siteItemsName objectAtIndex:index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    ContentViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    
    if([[siteInfo.siteItemsName objectAtIndex:index] isEqualToString:@"Info"])
    {
        [cvc setSiteInfo: siteInfo];
        cvc.isBase = YES;
    }
    else
    {
        cvc.isBase = NO;
    }
    
    [cvc setContentString:[siteInfo.siteItemsContent objectAtIndex:index]];
    
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 0.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}

-(void)pictureView
{
    PicturesViewController *pictureController=[self.storyboard instantiateViewControllerWithIdentifier:@"PicturesViewController"];
    pictureController.topicName = self.topicName;
    pictureController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:pictureController animated:YES];
}

@end
