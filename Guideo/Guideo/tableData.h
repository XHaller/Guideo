//
//  tableData.h
//  Guideo
//
//  Created by 亮亮 李 on 15/4/14.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tableData : NSObject

@property (nonatomic, strong) NSString *tableTopic; // name of recipe
@property (nonatomic, strong) NSString *tableContent; // preparation time
@property (nonatomic, strong) NSString *tableImage; // image filename of recipe

@end
