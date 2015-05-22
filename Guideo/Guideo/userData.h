//
//  userData.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/21.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userData : NSObject
{
    NSString* userName;
    NSString* email;
    NSString* userIntro;
    NSString* userImage;
}

@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *userIntro;
@property(nonatomic,retain)NSString *userImage;

+ (id)sharedSingletonClass;

@end
