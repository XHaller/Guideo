//
//  YFJLeftSwipeStoreTableView.m
//
//  Provides drop-in TableView component that allows to show iOS7 style left-swipe store
//
//  Created by Yuichi Fujiki on 6/27/13.
//  Copyright (c) 2013 Yuichi Fujiki. All rights reserved.
//

#import "SwipeStoreTableView.h"
#import <objc/runtime.h>

const static CGFloat kStoreButtonWidth = 80.f;
const static CGFloat kStoreButtonHeight = 44.f;

#define screenWidth() (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)


const static char * SwipeStoreTableViewCellIndexPathKey = "SwipeStoreTableViewCellIndexPathKey";

@interface UIButton (NSIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPath;

@end

@implementation UIButton (NSIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, SwipeStoreTableViewCellIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath *)indexPath {
    id obj = objc_getAssociatedObject(self, SwipeStoreTableViewCellIndexPathKey);
    if([obj isKindOfClass:[NSIndexPath class]]) {
        return (NSIndexPath *)obj;
    }
    return nil;
}

@end

@interface SwipeStoreTableView() {
    UISwipeGestureRecognizer * _leftGestureRecognizer;
    UISwipeGestureRecognizer * _rightGestureRecognizer;
    UITapGestureRecognizer * _tapGestureRecognizer;

    UIButton * _storeButton;

    NSIndexPath * _editingIndexPath;
}

@end

@implementation SwipeStoreTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    NSLog(@"whhh!!");
    if (self) {
        _leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        _leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        _leftGestureRecognizer.delegate = self;
        [self addGestureRecognizer:_leftGestureRecognizer];

        _rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        _rightGestureRecognizer.delegate = self;
        _rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_rightGestureRecognizer];

        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        _tapGestureRecognizer.delegate = self;
        // Don't add this yet

        _storeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _storeButton.frame = CGRectMake(screenWidth(), 0, kStoreButtonWidth, kStoreButtonHeight);
        _storeButton.backgroundColor = [UIColor redColor];
        _storeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_storeButton setTitle:@"Interested" forState:UIControlStateNormal];
        [_storeButton addTarget:self action:@selector(storeSite:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_storeButton];

        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // drawing code
 }
 */

- (void)swiped:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSIndexPath * indexPath = [self cellIndexPathForGestureRecognizer:gestureRecognizer];
    NSLog(@"what!!");
    if(indexPath == nil)
        return;

    if(![self.dataSource tableView:self canEditRowAtIndexPath:indexPath]) {
        return;
    }

    if(gestureRecognizer == _leftGestureRecognizer && ![_editingIndexPath isEqual:indexPath]) {
        UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
        [self setEditing:YES atIndexPath:indexPath cell:cell];
    } else if (gestureRecognizer == _rightGestureRecognizer && [_editingIndexPath isEqual:indexPath]){
        UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
        [self setEditing:NO atIndexPath:indexPath cell:cell];
    }
}

- (void)tapped:(UIGestureRecognizer *)gestureRecognizer
{
    if(_editingIndexPath) {
        UITableViewCell * cell = [self cellForRowAtIndexPath:_editingIndexPath];
        [self setEditing:NO atIndexPath:_editingIndexPath cell:cell];
    }
}

- (NSIndexPath *)cellIndexPathForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    UIView * view = gestureRecognizer.view;
    if(![view isKindOfClass:[UITableView class]]) {
        return nil;
    }

    CGPoint point = [gestureRecognizer locationInView:view];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    return indexPath;
}

- (void)setEditing:(BOOL)editing atIndexPath:indexPath cell:(UITableViewCell *)cell {

    if(editing) {
        if(_editingIndexPath) {
            UITableViewCell * editingCell = [self cellForRowAtIndexPath:_editingIndexPath];
            [self setEditing:NO atIndexPath:_editingIndexPath cell:editingCell];
        }
        [self addGestureRecognizer:_tapGestureRecognizer];
    } else {
        [self removeGestureRecognizer:_tapGestureRecognizer];
    }

    CGRect frame = cell.frame;

    CGFloat cellXOffset;
    CGFloat storeButtonXOffsetOld;
    CGFloat storeButtonXOffset;

    if(editing) {
        cellXOffset = -kStoreButtonWidth;
        storeButtonXOffset = screenWidth() - kStoreButtonWidth;
        storeButtonXOffsetOld = screenWidth();
        _editingIndexPath = indexPath;
    } else {
        cellXOffset = 0;
        storeButtonXOffset = screenWidth();
        storeButtonXOffsetOld = screenWidth() - kStoreButtonWidth;
        _editingIndexPath = nil;
    }

    CGFloat cellHeight = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
    _storeButton.frame = (CGRect) {storeButtonXOffsetOld, frame.origin.y, _storeButton.frame.size.width, cellHeight};
    _storeButton.indexPath = indexPath;

    [UIView animateWithDuration:0.2f animations:^{
        cell.frame = CGRectMake(cellXOffset, frame.origin.y, frame.size.width, frame.size.height);
        _storeButton.frame = (CGRect) {storeButtonXOffset, frame.origin.y, _storeButton.frame.size.width, cellHeight};
    }];
}

#pragma mark - Interaciton
- (void)storeSite:(id)sender {
    UIButton * storeButton = (UIButton *)sender;
    NSIndexPath * indexPath = storeButton.indexPath;

    [self.dataSource tableView:self commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    
    _editingIndexPath = nil;

    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _storeButton.frame;
        _storeButton.frame = (CGRect){frame.origin, frame.size.width, 0};
    } completion:^(BOOL finished) {
        CGRect frame = _storeButton.frame;
        _storeButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kStoreButtonHeight};
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO; // Recognizers of this class are the first priority
}

@end
