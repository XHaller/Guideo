//
//  AddNoteViewController.h
//  Guideo
//
//  Created by wei on 15/5/12.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

//
//  ViewController.h
//  ImagePicker
//
//  Created by Seungbo Cho on 2014. 1. 23..
//  Copyright (c) 2014년 Seungbo Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoImagePickerController.h"

@interface AddNoteViewController : UIViewController <DoImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView    *iv1;
@property (strong, nonatomic)   NSArray             *aIVs;

@property (weak, nonatomic) IBOutlet UISegmentedControl     *sgColumnCount;
@property (weak, nonatomic) IBOutlet UISegmentedControl     *sgMaxCount;

- (IBAction)onShowImagePicker:(id)sender;

@end
