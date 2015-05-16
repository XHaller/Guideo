//
//  SignUpViewController.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/16.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize greetlabel1, greetlabel2, greetlabel3, usernameField, emailField, passwordField, retypeField, backButton, signupButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [greetlabel1 setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20.0]];
    [greetlabel2 setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20.0]];
    
    greetlabel1=[[UILabel alloc]initWithFrame:CGRectMake(70, 80, 200, 50)];
    [greetlabel1 setText:@"On My Way, "];
    [greetlabel1 setFont:[UIFont fontWithName:@"Cochin-BoldItalic" size:30.0f]];
    [greetlabel1 setTextColor:[UIColor whiteColor]];
    [greetlabel1 setTextAlignment:NSTextAlignmentCenter];
    [greetlabel1 setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [greetlabel1 setLineBreakMode:NSLineBreakByCharWrapping];
    [greetlabel1 setNumberOfLines:1];
    [greetlabel1 setClipsToBounds:YES];
    [self.view addSubview:greetlabel1];
    
    
    
    
    
    greetlabel2=[[UILabel alloc]initWithFrame:CGRectMake(130, 120, 180, 50)];
    [greetlabel2 setText:@"In My Way"];
    [greetlabel2 setFont:[UIFont fontWithName:@"Cochin-BoldItalic" size:30.0f]];
    [greetlabel2 setTextColor:[UIColor whiteColor]];
    [greetlabel2 setTextAlignment:NSTextAlignmentCenter];
    [greetlabel2 setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [greetlabel2 setLineBreakMode:NSLineBreakByCharWrapping];
    [greetlabel2 setNumberOfLines:1];
    [greetlabel2 setClipsToBounds:YES];
    [self.view addSubview:greetlabel2];
    
    
    greetlabel3=[[UILabel alloc]initWithFrame:CGRectMake(65, 180, 250, 50)];
    [greetlabel3 setText:@"Make your trip safe and fun!"];
    [greetlabel3 setFont:[UIFont fontWithName:@"DamascusBold" size:15.0f]];
    [greetlabel3 setTextColor:[UIColor whiteColor]];
    [greetlabel3 setTextAlignment:NSTextAlignmentCenter];
    [greetlabel3 setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [greetlabel3 setLineBreakMode:NSLineBreakByCharWrapping];
    [greetlabel3 setNumberOfLines:1];
    [greetlabel3 setClipsToBounds:YES];
    [self.view addSubview:greetlabel3];
    
    
    
    usernameField = [[UITextField alloc]initWithFrame:CGRectMake(65, 250, 250, 45)];
    usernameField.borderStyle = UITextBorderStyleRoundedRect;
    usernameField.layer.cornerRadius = 15.0f;
    usernameField.layer.masksToBounds=YES;
    usernameField.layer.borderColor=[[UIColor whiteColor]CGColor];
    usernameField.layer.borderWidth= 2.0f;
    [usernameField setBackgroundColor:[UIColor clearColor]];
    usernameField.placeholder = @"  Create a username, please ;)";
    usernameField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    usernameField.textColor = [UIColor whiteColor];
    usernameField.clearButtonMode = UITextFieldViewModeAlways;
    usernameField.textAlignment = UITextAlignmentLeft;
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    [self.view addSubview:usernameField];
    
    emailField = [[UITextField alloc]initWithFrame:CGRectMake(65, 320, 250, 45)];
    emailField.borderStyle = UITextBorderStyleRoundedRect;
    emailField.layer.cornerRadius = 15.0f;
    emailField.layer.masksToBounds=YES;
    emailField.layer.borderColor=[[UIColor whiteColor]CGColor];
    emailField.layer.borderWidth= 2.0f;
    [emailField setBackgroundColor:[UIColor clearColor]];
    emailField.placeholder = @"  Your email address, please ;)";
    emailField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    emailField.textColor = [UIColor whiteColor];
    emailField.clearButtonMode = UITextFieldViewModeAlways;
    emailField.textAlignment = UITextAlignmentLeft;
    emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    [self.view addSubview:emailField];
    
    
    passwordField = [[UITextField alloc]initWithFrame:CGRectMake(65, 390, 250, 45)];
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.layer.cornerRadius = 15.0f;
    passwordField.layer.masksToBounds=YES;
    passwordField.layer.borderColor=[[UIColor whiteColor]CGColor];
    passwordField.layer.borderWidth= 2.0f;
    [passwordField setBackgroundColor:[UIColor clearColor]];
    passwordField.placeholder = @"  Create a password, please ;)";
    passwordField.secureTextEntry = YES;
    passwordField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    passwordField.textColor = [UIColor whiteColor];
    passwordField.clearButtonMode = UITextFieldViewModeAlways;
    passwordField.textAlignment = UITextAlignmentLeft;
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    [self.view addSubview:passwordField];
    
    
    retypeField = [[UITextField alloc]initWithFrame:CGRectMake(65, 460, 250, 45)];
    retypeField.borderStyle = UITextBorderStyleRoundedRect;
    retypeField.layer.cornerRadius = 15.0f;
    retypeField.layer.masksToBounds=YES;
    retypeField.layer.borderColor=[[UIColor whiteColor]CGColor];
    retypeField.layer.borderWidth= 2.0f;
    [retypeField setBackgroundColor:[UIColor clearColor]];
    retypeField.placeholder = @"  Retype the password, please ;)";
    retypeField.secureTextEntry = YES;
    retypeField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    retypeField.textColor = [UIColor whiteColor];
    retypeField.clearButtonMode = UITextFieldViewModeAlways;
    retypeField.textAlignment = UITextAlignmentLeft;
    retypeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    retypeField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    [self.view addSubview:retypeField];

    
    
    
    
    UIColor* textColor = [UIColor colorWithRed:(47.0/255.0) green:(180.0/255.0) blue:(79.0/255.0) alpha:1.0];
    
    UIImage* newImage = [self blurWithCoreImage:[UIImage imageNamed:@"initial.jpg"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: newImage];
    
    
    signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signupButton.frame = CGRectMake(65, 500, 70, 45);
    [signupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signupButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [signupButton setBackgroundColor: textColor];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signupButton addTarget:self action:@selector(signupClicked:) forControlEvents:UIControlEventTouchUpInside];
    [signupButton.layer setMasksToBounds:YES];
    [signupButton.layer setCornerRadius:10.0];
    
    [self.view addSubview:self.signupButton];
    
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(120, 500, 70, 45);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [backButton setBackgroundColor: [UIColor whiteColor]];
    [backButton setTitleColor:textColor forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backButton.layer setMasksToBounds:YES];
    [backButton.layer setCornerRadius:10.0];
    
    [self.view addSubview:self.backButton];
    
    //greetlabel1.textAlignment = NSTextAlignmentCenter;
    //greetlabel2.textAlignment = NSTextAlignmentCenter;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) signupClicked:(id)sender {
    [self performSegueWithIdentifier:@"signIn" sender:self];
}

- (IBAction) backClicked:(id)sender {
    [self performSegueWithIdentifier:@"signIn" sender:self];
}

- (IBAction)tapReturn:(id)sender {
    [self.view endEditing:YES];
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

- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@30 forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    
    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.view.frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, self.view.frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, self.view.frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
