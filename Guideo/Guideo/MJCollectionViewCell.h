//
//  MJCollectionViewCell.h
//  Guideo
//
//  Created by wei on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_HEIGHT 180
#define IMAGE_OFFSET_SPEED 25
#define IMAGE_WIDTH 300
@interface MJCollectionViewCell : UICollectionViewCell

/*
 
 image used in the cell which will be having the parallax effect
 
 */
@property (nonatomic, strong, readwrite) UIImage *image;

/*
 Image will always animate according to the imageOffset provided. Higher the value means higher offset for the image
 */
@property (nonatomic, assign, readwrite) CGPoint imageOffset;

@end
