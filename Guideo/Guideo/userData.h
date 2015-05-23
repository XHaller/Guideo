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

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *userIntro;
@property(nonatomic,strong)NSString *userImage;

+ (userData*)sharedSingletonClass;

@end
