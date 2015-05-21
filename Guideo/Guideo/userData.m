//
//  userData.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/21.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "userData.h"

@implementation userData

static NSString* userName;

+ (NSString*) getUsername
{  return userName; }
+ (void) setUsername:(NSString*)val
{ userName = val; }

static NSString* emailaddress;
+ (NSString*) getEmail
{  return emailaddress; }
+ (void) setEmail:(NSString*)val
{ emailaddress = val; }

static NSString* userIntro;
+ (NSString*) getUserIntro
{  return userIntro; }
+ (void) setUserintro:(NSString*)val
{ userIntro = val; }

static NSString* userImage;
+ (NSString*) getUserImage
{ return userImage; }
+ (void) setUserimage:(NSString*)val
{ userIntro = val; }

@end
