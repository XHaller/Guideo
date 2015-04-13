//
//  ExploreCollectionViewCell.h
//  Guideo
//
//  Created by wei on 15/4/12.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, assign) CGFloat cardRadius;
@property (nonatomic, strong) UIImage *blurImage;
@end

