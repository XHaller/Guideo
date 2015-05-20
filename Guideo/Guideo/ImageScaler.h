//
//  ImageScaler.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/20.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageScaler : NSObject

+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;

@end
