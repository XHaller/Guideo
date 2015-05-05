//
//  ExploreViewController.m
//  Guideo
//
//  Created by wei on 15/4/12.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "ExploreViewController.h"
#import "MCCardPickerCollectionViewController.h"
#import "ExploreCollectionViewCell.h"

static NSString *const kCellIdentifier = @"ExploreNote";

@interface ExploreViewController ()<MCCardPickerCollectionViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) MCCardPickerCollectionViewController *cardViewController;
@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Pick One for Bonus!";
    
    self.cardViewController = [[MCCardPickerCollectionViewController alloc] init];
    self.cardViewController.delegate = self;
    [self.cardViewController.collectionView registerClass:[ExploreCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // check if searchDisplayController still active..
    if ([self.searchDisplayController isActive]) {
        [self.searchDisplayController setActive:NO];
    }
}


- (IBAction)showPicker:(id)sender {
    [self.cardViewController presentInViewController:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.cardRadius = 4.0;
    cell.label.text = @"Site";
    return cell;
}

#pragma mark - MCCardPickerCollectionViewControllerDelegate

- (void)cardPickerCollectionViewController:(MCCardPickerCollectionViewController *)cardPickerCollectionViewController preparePresentingView:(UIView *)presentingView fromSelectedCell:(UICollectionViewCell *)cell
{
    // Let the MCCardPickerCollectionViewController take care of scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.delegate = cardPickerCollectionViewController;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 900, CGRectGetWidth(self.view.frame)-40, 30);
    [button setTitle:@"Choose Me :)" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:0.15 green:0.65 blue:0.69 alpha:1]];
    [scrollView addSubview:button];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(button.frame)+100)];
    [presentingView addSubview:scrollView];
    
    UIImage *blurImage = [(ExploreCollectionViewCell *)cell blurImage];
    presentingView.layer.contents = (id)blurImage.CGImage;
}

@end