//
//  EventViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *events;
@property NSMutableArray * searchResults;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

@end
