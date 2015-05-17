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

@synthesize scrollView, contentString;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [scrollView setScrollEnabled:YES];
    
    UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(20,188,280,260)];
    [contentView setText:contentString];
    contentView.textColor = [UIColor lightGrayColor];
    contentView.font = [UIFont systemFontOfSize:14];
    [contentView setBackgroundColor:[UIColor clearColor]];
    contentView.editable = NO;
    contentView.scrollEnabled = YES;
    [scrollView addSubview:contentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
