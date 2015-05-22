//
//  userData.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/21.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "userData.h"

@implementation userData

@synthesize userName, email, userIntro, userImage;

+ (id)sharedSingletonClass
{
    static userData *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

@end
