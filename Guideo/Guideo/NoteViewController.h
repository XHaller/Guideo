//
//  NoteViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/24.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *notes;
@property NSMutableArray * searchResults;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

@end
