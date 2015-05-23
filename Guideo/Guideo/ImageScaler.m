//
//  ImageScaler.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/20.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "ImageScaler.h"

@implementation ImageScaler

+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
