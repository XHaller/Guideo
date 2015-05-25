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
#import "userData.h"

@interface AddNoteViewController ()
{
    BOOL flag;
    userData *user;
}
@property (strong, nonatomic) IBOutlet UITextView *textName;

@end

@implementation AddNoteViewController

@synthesize textName, iv1, aIVs, sgMaxCount, sgColumnCount;


- (IBAction)clearImage:(id)sender {
    for (UIImageView *iv in aIVs)
        iv.image = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    user = [userData sharedSingletonClass];
    
    flag = NO;
    aIVs = @[iv1];
    sgColumnCount.selectedSegmentIndex = 1;
    sgMaxCount.selectedSegmentIndex    = 1;
    textName.text = @" Create Some Text Here~";
    textName.textColor = [UIColor lightGrayColor];
    textName.delegate = self;
    
    textName.layer.cornerRadius = 5;
    textName.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    textName.layer.borderWidth = 1;
    
    iv1.layer.cornerRadius = 5;
    iv1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    iv1.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(flag == NO)
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        flag = YES;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Text Here~";
        [textView resignFirstResponder];
        flag = NO;
    }
}

- (IBAction)onShowImagePicker:(id)sender
{
    for (UIImageView *iv in aIVs)
        iv.image = nil;
    
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
    if (sgMaxCount.selectedSegmentIndex == 0)
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
            UIImageView *iv = aIVs[i];
            iv.image = aSelected[i];
        }
    }
    else if (picker.nResultType == DO_PICKER_RESULT_ASSET)
    {
        for (int i = 0; i < MIN(4, aSelected.count); i++)
        {
            UIImageView *iv = aIVs[i];
            iv.image = [ASSETHELPER getImageFromAsset:aSelected[i] type:ASSET_PHOTO_SCREEN_SIZE];
        }
        
        [ASSETHELPER clearData];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textName resignFirstResponder];
}

- (IBAction)uploadImage:(id)sender
{
    NSInteger success = 0;
    NSString* username = user.userName;
    NSDictionary *keyPair = @{@"username": username, @"text": textName.text};
    NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/note/upload" httpMethod:@"POST" params:keyPair];
    /*
    NSData *imageData = UIImagePNGRepresentation(iv1.image);
    
    NSString *urlString = [ NSString stringWithFormat:@"http://yourUploadImageURl.php?intid=%@",@"image"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831464368775746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"text"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",textName.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", @"image"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSError *error;
    NSHTTPURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSDictionary *jsonData = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
        if(jsonData == NULL)
        {
            [self alertStatus:@"Connection Failed" :@"Upload Failed!" :0];
        }
        else
        {
            [self alertStatus:@"Notes are Updated" :@"Upload Successfully!" :0];
        }
    }*/
    success = [jsonData[@"upload"] integerValue];
    
    NSLog(@"Success: %ld",(long)success);
    
    if(success == 1)
    {
        [self alertStatus:@"Notes are Updated" :@"Upload Successfully!" :0];
    }
    else
    {
        [self alertStatus:@"Notes are Discarded" :@"Upload Failed!" :0];
    }
    
    textName.textColor = [UIColor lightGrayColor];
    textName.text = @"Text Here~";
    [textName resignFirstResponder];
    flag = NO;
    for (UIImageView *iv in aIVs)
        iv.image = nil;
    
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

@end
