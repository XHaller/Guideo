//
//  UserViewController.m
//  Guideo
//
//  Created by wei on 15/5/9.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"
#import "RKCardView.h"
#import "DataTransfer.h"
#import "userData.h"
#define BUFFERX 20 //distance from side to the card (higher makes thinner card)
#define BUFFERY 40 //distance from top to the card (higher makes shorter card)
    
@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    userData *user = [userData sharedSingletonClass];
    
    RKCardView* cardView= [[RKCardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    cardView.coverImageView.image = [UIImage imageNamed:@"exampleCover"];
    cardView.profileImageView.image = [UIImage imageNamed:@"exampleProfile"];
    NSString* username = user.userName;
    cardView.titleLabel.text = username;
    cardView.delegate = self;
    //    [cardView addBlur];
    //    [cardView addShadow];
    [self.view addSubview:cardView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Optional RKCardViewDelegate methods

-(void)nameTap {
    NSLog(@"Taped on name");
}

-(void)coverPhotoTap {
    NSLog(@"Taped on cover photo");
}

-(void)profilePhotoTap {
    NSLog(@"Taped on profile photo");
}
@end