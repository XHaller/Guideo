//
//  AddNoteViewController.h
//  Guideo
//
//  Created by wei on 15/5/12.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DoImagePickerController.h"

@interface AddNoteViewController : UIViewController <DoImagePickerControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView    *iv1;
@property (strong, nonatomic)   NSArray             *aIVs;

@property (weak, nonatomic) IBOutlet UISegmentedControl     *sgColumnCount;
@property (weak, nonatomic) IBOutlet UISegmentedControl     *sgMaxCount;

- (IBAction)clearImage:(id)sender;
- (IBAction)onShowImagePicker:(id)sender;
- (IBAction)uploadImage:(id)sender;

@end
