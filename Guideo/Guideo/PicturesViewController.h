//
//  PicturesViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>

// This serves, mostly, as an "update stuff after dismissing"
@protocol NSGAlleryDelegate <NSObject>
@optional
- (void)imageSelected:(UIImageView*)image;
@end

@interface PicturesViewController : UIViewController

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) id <NSGAlleryDelegate> delegate;
@property(strong, nonatomic) NSString *topicName;

@end