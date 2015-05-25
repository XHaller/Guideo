//
//  NoteDetailViewController.h
//  Guideo
//
//  Created by wei on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteDetailViewController : UIViewController

@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSString *image;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

@end
