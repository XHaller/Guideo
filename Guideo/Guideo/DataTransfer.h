//
//  DataTransfer.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/17.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransfer : NSObject
{
}

+ (NSDictionary *)requestObjectWithURL:(NSString *)urladdress httpMethod:(NSString *)httpMethod params:(NSDictionary *)sendParams;

+ (NSArray *)requestArrayWithURL:(NSString *)urladdress httpMethod:(NSString *)httpMethod params:(NSDictionary *)sendParams;

@end
