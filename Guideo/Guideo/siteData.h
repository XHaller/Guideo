//
//  siteData.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/17.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface siteData : NSObject

@property (nonatomic, strong) NSString *siteName;
@property (nonatomic, strong) NSString *siteAddress;

@property (nonatomic, strong) NSString* siteOpen;
@property (nonatomic, strong) NSString* siteTripTime;
@property (nonatomic, strong) NSString* sitePopularity;
@property (nonatomic, assign) float siteLatitude;
@property (nonatomic, assign) float siteLongitude;
@property (nonatomic, strong) NSString* sitePrice;

@property (nonatomic, strong) NSString *sitePhone;
@property (nonatomic, strong) NSString *siteIntro;
@property (nonatomic, strong) NSMutableArray *siteItemsName;
@property (nonatomic, strong) NSMutableArray *siteItemsContent;

@end
