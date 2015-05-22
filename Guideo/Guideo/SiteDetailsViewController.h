//
//  SiteDetailsViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/4/15.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "siteData.h"
#import "ViewPagerController.h"

@interface SiteDetailsViewController : ViewPagerController

@property(strong, nonatomic) NSString *topicName;
@property siteData *siteInfo;

@end
