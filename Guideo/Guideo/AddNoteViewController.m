//
//  AddNoteViewController.m
//  Guideo
//
//  Created by wei on 15/5/12.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "AddNoteViewController.h"
#import "AssetHelper.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _aIVs = @[_iv1];
    _sgColumnCount.selectedSegmentIndex = 1;
    _sgMaxCount.selectedSegmentIndex    = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowImagePicker:(id)sender
{
    for (UIImageView *iv in _aIVs)
        iv.image = nil;
    
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;

    cont.nMaxCount = 1;

    
    cont.nColumnCount = 2;
    
    [self presentViewController:cont animated:YES completion:nil];
}

#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        for (int i = 0; i < MIN(4, aSelected.count); i++)
        {
            UIImageView *iv = _aIVs[i];
            iv.image = aSelected[i];
        }
    }
    else if (picker.nResultType == DO_PICKER_RESULT_ASSET)
    {
        for (int i = 0; i < MIN(4, aSelected.count); i++)
        {
            UIImageView *iv = _aIVs[i];
            iv.image = [ASSETHELPER getImageFromAsset:aSelected[i] type:ASSET_PHOTO_SCREEN_SIZE];
        }
        
        [ASSETHELPER clearData];
    }
}

@end
