//
//  ContentViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

@synthesize scrollView, contentString, isBase;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(20,0,335,450)];
    [contentView setText:contentString];
    contentView.textColor = [UIColor blackColor];
    contentView.font = [UIFont systemFontOfSize:15];
    [contentView setBackgroundColor:[UIColor clearColor]];
    contentView.editable = NO;
    contentView.scrollEnabled = YES;
    contentView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    contentView.layer.borderWidth= 2.0f;
    [scrollView addSubview:contentView];
    scrollView.scrollEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
