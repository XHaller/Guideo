//
//  SearchDisplayController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SearchDisplayController.h"


@implementation SearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive: visible animated: NO];
    
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
}

@end