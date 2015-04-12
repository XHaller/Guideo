//
//  ExpandHeader.m
//  Guideo
//
//  Created by 亮亮 李 on 15/4/11.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#define ExpandContentOffset @"contentOffset"

#import "ExpandHeader.h"

@implementation ExpandHeader{
    __weak UIScrollView *_scrollView; //scrollView或者其子类
    __weak UIView *_expandView; //背景可以伸展的View
    
    CGFloat _expandHeight;
}

- (void)dealloc{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:ExpandContentOffset];
        _scrollView = nil;
    }
    _expandView = nil;
}

+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    ExpandHeader *expandHeader = [ExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView{
    
    
    _expandHeight = CGRectGetHeight(expandView.frame);
    
    _scrollView = scrollView;
    _scrollView.contentInset = UIEdgeInsetsMake(_expandHeight, 0, 0, 0);
    [_scrollView insertSubview:expandView atIndex:0];
    [_scrollView addObserver:self forKeyPath:ExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView setContentOffset:CGPointMake(0, -180)];
    
    _expandView = expandView;
    
    //使View可以伸展效果  重要属性
    _expandView.contentMode= UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
    
    [self reSizeView];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:ExpandContentOffset]) {
        return;
    }
    [self scrollViewDidScroll:_scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < _expandHeight * -1) {
        CGRect currentFrame = _expandView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        _expandView.frame = currentFrame;
    }
    
}

- (void)reSizeView{
    
    //重置_expandView位置
    [_expandView setFrame:CGRectMake(0, -1*_expandHeight, CGRectGetWidth(_expandView.frame), _expandHeight)];
    
}

@end

