//
//  ViewController.m
//  RKCard
//
//  Created by Richard Kim on 11/5/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "ViewController.h"
#import "RKCardView.h"

#define BUFFERX 20 //distance from side to the card (higher makes thinner card)
#define BUFFERY 40 //distance from top to the card (higher makes shorter card)

@interface ViewController ()

@property RKCardView* cardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    
    _cardView = [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, BUFFERY, self.view.frame.size.width-2*BUFFERX, self.view.frame.size.height-2*BUFFERY)];
    
    _cardView.coverImageView.image = [UIImage imageNamed:@"exampleCover"];
    _cardView.profileImageView.image = [UIImage imageNamed:@"exampleProfile"];
    _cardView.titleLabel.text = @"Richard Kim";
    _cardView.delegate = self;
//    [cardView addBlur];
//    [cardView addShadow];
    [self.view addSubview:_cardView];
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
