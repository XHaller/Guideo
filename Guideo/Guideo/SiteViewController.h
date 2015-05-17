//
//  SiteViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface SiteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property NSMutableArray *sites;
@property NSMutableArray * searchResults;


@end