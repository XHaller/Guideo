//
//  AddNoteViewController.m
//  Guideo
//
//  Created by wei on 15/5/12.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "AddNoteViewController.h"
#import "AssetHelper.h"
#import "DataTransfer.h"

@interface AddNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textName;

@end

@implementation AddNoteViewController
- (IBAction)submitNote:(id)sender {
    NSLog(@"submit note");
//    NSDictionary *keyPair = @{@"username" : [self.textName text], @"text" : [self.textName text], @"image_url": [self.textName text]};
//    NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/addNote" httpMethod:@"POST" params:keyPair];
    
}

- (IBAction)clearImage:(id)sender {
    for (UIImageView *iv in _aIVs)
        iv.image = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _aIVs = @[_iv1];
    _sgColumnCount.selectedSegmentIndex = 1;
    _sgMaxCount.selectedSegmentIndex    = 1;
    _textName.text = @"Text Here~";
    _textName.textColor = [UIColor lightGrayColor];
    _textName.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Text Here~";
        [textView resignFirstResponder];
    }
}

- (IBAction)onShowImagePicker:(id)sender
{
    for (UIImageView *iv in _aIVs)
        iv.image = nil;
    
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
    if (_sgMaxCount.selectedSegmentIndex == 0)
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textName resignFirstResponder];

}

@end
