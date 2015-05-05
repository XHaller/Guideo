//
//  SearchDisplayController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SearchDisplayController.h"

@interface mySearchDisplayController : UISearchDisplayController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@end

@implementation SearchDisplayController

-(void)searchDisplayControllerWillBeginSearch:(SearchDisplayController *)controller
{
    self.searchResultsDataSource = self;
    self.searchResultsTableView.delegate = self;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        CGRect statusBarFrame =  [[UIApplication sharedApplication] statusBarFrame];
        [UIView animateWithDuration:0.01 animations:^{
            for (UIView *subview in self.searchBar.subviews)
                subview.transform = CGAffineTransformMakeTranslation(0, statusBarFrame.size.height);
        }];
    }
}

-(void)searchDisplayControllerWillEndSearch:(SearchDisplayController *)controller
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        [UIView animateWithDuration:0.01 animations:^{
            for (UIView *subview in self.searchBar.subviews)
                subview.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
