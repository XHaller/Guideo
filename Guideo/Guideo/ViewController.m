//
//  ViewController.m
//  Login
//
//  Created by 亮亮 李 on 15/4/5.
//  Copyright (c) 2015年 Kyran. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "userData.h"
#import "DataTransfer.h"

@interface ViewController ()
{
    userData *user;
}

@end


@implementation ViewController

@synthesize greetlabel1, greetlabel2, greetlabel3, usernameField, emailField, passwordField, retypeField, signinButton, sendButton, signup1Button, signup2Button, forgetButton, backButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    user = [userData sharedSingletonClass];
    
    greetlabel1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-120, 50, 200, 50)];
    [greetlabel1 setText:@"On My Way, "];
    [greetlabel1 setFont:[UIFont fontWithName:@"Cochin-BoldItalic" size:30.0f]];
    [greetlabel1 setTextColor:[UIColor whiteColor]];
    [greetlabel1 setTextAlignment:NSTextAlignmentCenter];
    [greetlabel1 setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [greetlabel1 setLineBreakMode:NSLineBreakByCharWrapping];
    [greetlabel1 setNumberOfLines:1];
    [greetlabel1 setClipsToBounds:YES];
    [self.view addSubview:greetlabel1];
    
    greetlabel2=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 90, 180, 50)];
    [greetlabel2 setText:@"In My Way"];
    [greetlabel2 setFont:[UIFont fontWithName:@"Cochin-BoldItalic" size:30.0f]];
    [greetlabel2 setTextColor:[UIColor whiteColor]];
    [greetlabel2 setTextAlignment:NSTextAlignmentCenter];
    [greetlabel2 setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [greetlabel2 setLineBreakMode:NSLineBreakByCharWrapping];
    [greetlabel2 setNumberOfLines:1];
    [greetlabel2 setClipsToBounds:YES];
    [self.view addSubview:greetlabel2];
    
    
    greetlabel3=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 140, 250, 50)];
    [greetlabel3 setText:@"Make your trip safe and fun!"];
    [greetlabel3 setFont:[UIFont fontWithName:@"DamascusBold" size:15.0f]];
    [greetlabel3 setTextColor:[UIColor whiteColor]];
    [greetlabel3 setTextAlignment:NSTextAlignmentCenter];
    [greetlabel3 setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [greetlabel3 setLineBreakMode:NSLineBreakByCharWrapping];
    [greetlabel3 setNumberOfLines:1];
    [greetlabel3 setClipsToBounds:YES];
    [self.view addSubview:greetlabel3];
    
    
    
    usernameField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 200, 250, 45)];
    usernameField.borderStyle = UITextBorderStyleRoundedRect;
    usernameField.layer.cornerRadius = 15.0f;
    usernameField.layer.masksToBounds=YES;
    usernameField.layer.borderColor=[[UIColor whiteColor]CGColor];
    usernameField.layer.borderWidth= 2.0f;
    [usernameField setBackgroundColor:[UIColor clearColor]];
    usernameField.placeholder = @"  Your username, please ;)";
    usernameField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    usernameField.textColor = [UIColor whiteColor];
    usernameField.clearButtonMode = UITextFieldViewModeAlways;
    usernameField.textAlignment = UITextAlignmentLeft;
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

    [self.view addSubview:usernameField];
    
    
    emailField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 270, 250, 45)];
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

    
    
    passwordField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 270, 250, 45)];
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.layer.cornerRadius = 15.0f;
    passwordField.layer.masksToBounds=YES;
    passwordField.layer.borderColor=[[UIColor whiteColor]CGColor];
    passwordField.layer.borderWidth= 2.0f;
    [passwordField setBackgroundColor:[UIColor clearColor]];
    passwordField.placeholder = @"  Your password, please ;)";
    passwordField.secureTextEntry = YES;
    passwordField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    passwordField.textColor = [UIColor whiteColor];
    passwordField.clearButtonMode = UITextFieldViewModeAlways;
    passwordField.textAlignment = UITextAlignmentLeft;
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

    [self.view addSubview:passwordField];
    
    
    retypeField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-125, 410, 250, 45)];
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

    
    signinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signinButton.frame = CGRectMake(self.view.frame.size.width/2-75, 350, 150, 45);
    [signinButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [signinButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [signinButton setBackgroundColor: textColor];
    [signinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signinButton addTarget:self action:@selector(signinClicked:) forControlEvents:UIControlEventTouchUpInside];
    [signinButton.layer setMasksToBounds:YES];
    [signinButton.layer setCornerRadius:10.0];

    [self.view addSubview:self.signinButton];
    
    signup1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signup1Button.frame = CGRectMake(self.view.frame.size.width/2-75, 420, 150, 45);
    [signup1Button setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signup1Button.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [signup1Button setBackgroundColor: [UIColor whiteColor]];
    [signup1Button setTitleColor:textColor forState:UIControlStateNormal];
    [signup1Button addTarget:self action:@selector(signup1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [signup1Button.layer setMasksToBounds:YES];
    [signup1Button.layer setCornerRadius:10.0];
    
    [self.view addSubview:self.signup1Button];
    
    signup2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signup2Button.frame = CGRectMake(self.view.frame.size.width/2-110, 470, 100, 45);
    [signup2Button setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signup2Button.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [signup2Button setBackgroundColor: textColor];
    [signup2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signup2Button addTarget:self action:@selector(signup2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [signup2Button.layer setMasksToBounds:YES];
    [signup2Button.layer setCornerRadius:10.0];
    
    [self.view addSubview:self.signup2Button];
    
    
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(self.view.frame.size.width/2+10, 470, 100, 45);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [backButton setBackgroundColor: [UIColor whiteColor]];
    [backButton setTitleColor:textColor forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backButton.layer setMasksToBounds:YES];
    [backButton.layer setCornerRadius:10.0];
    
    [self.view addSubview:self.backButton];
    
    
    
    forgetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    forgetButton.frame = CGRectMake(self.view.frame.size.width/2-75, 490, 150, 45);
    [forgetButton setTitle:@"Forget your password ?" forState:UIControlStateNormal];
    [forgetButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14.0f]];
    [forgetButton setBackgroundColor: [UIColor clearColor]];
    [forgetButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetClicked:) forControlEvents:UIControlEventTouchUpInside];
    forgetButton.layer.borderWidth = 0.0;
    
    [self.view addSubview:self.forgetButton];
    
    
    sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.frame = CGRectMake(self.view.frame.size.width/2-110, 420, 100, 45);
    [sendButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [sendButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
    [sendButton setBackgroundColor: textColor];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton.layer setCornerRadius:10.0];
    
    [self.view addSubview:self.sendButton];
    
    
    emailField.hidden = YES;
    retypeField.hidden = YES;
    sendButton.hidden = YES;
    signup2Button.hidden = YES;
    backButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction) signinClicked:(id)sender {
    
    NSInteger success = 0;
    @try{
        if([[self.usernameField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but please give me your Username!" :@"Sign in failed!" :0];
        }
        else if([[self.passwordField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but please give me your Password!" :@"Sign in failed!" :0];
        }
        else
        {
            NSDictionary *keyPair = @{@"username" : [self.usernameField text], @"password" : [self.passwordField text]};
            NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/login" httpMethod:@"POST" params:keyPair];
            
            if(jsonData == NULL)
            {
                user.userName = [self.usernameField text];
                user.email = @"email";
                user.userIntro = @"intro";
                user.userImage = @"image";
                NSLog(@"UserName: %@", user.userName);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
            else
            {
                success = [jsonData[@"login"] integerValue];
                
                NSLog(@"Success: %ld",(long)success);
            
                if(success == 1)
                {
                    user.userName = [self.usernameField text];
                    user.email = jsonData[@"email"];
                    user.userIntro = jsonData[@"intro"];
                    user.userImage = jsonData[@"image"];
                    NSLog(@"UserName: %@", user.userName);
                    NSLog(@"Login SUCCESS");
                } else {
                    user.userName = [self.usernameField text];
                    user.email = @"email";
                    user.userIntro = @"intro";
                    user.userImage = @"image";
                    //NSLog(@"UserName: %@", user.userName);
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    //NSLog(@"%@", jsonData);
                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
                }
           
            }
           // success = 1;
        }
    }
    @catch (NSException * e) {
        user.userName = [self.usernameField text];
        user.email = @"email";
        user.userIntro = @"intro";
        user.userImage = @"image";
        NSLog(@"UserName: %@", user.userName);
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success == 1) {
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }
    
}

- (IBAction)tapReturn:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction) signup1Clicked:(id)sender {
    emailField.hidden = NO;
    emailField.frame = CGRectMake(self.view.frame.size.width/2-125, 270, 250, 45);
    retypeField.hidden = NO;
    usernameField.text = nil;
    passwordField.text = nil;
    usernameField.placeholder = @"  Create a username, please ;)";
    passwordField.frame = CGRectMake(self.view.frame.size.width/2-125, 340, 250, 45);
    passwordField.placeholder = @"  Create a password, please ;)";
    signinButton.hidden = YES;
    signup2Button.hidden = NO;
    signup1Button.hidden = YES;
    backButton.frame = CGRectMake(self.view.frame.size.width/2+10, 470, 100, 45);
    backButton.hidden = NO;
    forgetButton.hidden = YES;
}

- (IBAction) signup2Clicked:(id)sender {
    
    NSInteger success = 0;
    NSString *nameRegex = @"[a-zA-Z][a-zA-Z0-9]*";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    NSString *emailRegex = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    @try{
        if([[self.usernameField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but please create a Username!" :@"Sign up failed!" :0];
        }
        else if(![pred1 evaluateWithObject:[self.usernameField text]])
        {
            [self alertStatus:@"Sorry, the username can only contain alphabets and numbers!" :@"Sign up failed!" :0];
            
        }
        else if(![pred2 evaluateWithObject:[self.emailField text]])
        {
            [self alertStatus:@"Sorry, the email is not valid!" :@"Sign up failed!" :0];
        }
        else if([[self.passwordField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but please create a Password!" :@"Sign up failed!" :0];
        }
        else if([[self.passwordField text] length] < 6)
        {
            [self alertStatus:@"Sorry, the password should contain at least 6 characters!" :@"Sign up failed!" :0];
        }
        else if(![[self.passwordField text] isEqualToString:[self.retypeField text]])
        {
            [self alertStatus:@"Sorry, the two passwords are not the same!" :@"Sign up failed!" :0];
        }
        else
        {
            NSDictionary *keyPair = @{@"username" : [self.usernameField text], @"email" : [self.emailField text], @"password" : [self.passwordField text]};
            NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/signup" httpMethod:@"POST" params:keyPair];
            
            if(jsonData == NULL)
            {
                [self alertStatus:@"Connection Failed" :@"Sign up Failed!" :0];
            }
            else
            {
                success = [jsonData[@"signup"] integerValue];
                
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    user.userName = [self.usernameField text];
                    user.email = [self.emailField text];
                    user.userIntro = @"";
                    user.userImage = @"";
                    
                    NSLog(@"Signup SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign up Failed!" :0];
                }
                
            }
            //success = 1;
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign up Failed." :@"Error!" :0];
    }
    if (success == 1) {
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }

}

- (IBAction) backClicked:(id)sender {
    emailField.hidden = YES;
    retypeField.hidden = YES;
    usernameField.text = nil;
    passwordField.text = nil;
    emailField.text = nil;
    retypeField.text = nil;
    usernameField.hidden = NO;
    passwordField.hidden = NO;
    usernameField.placeholder = @"  Your username, please ;)";
    passwordField.frame = CGRectMake(self.view.frame.size.width/2-125, 270, 250, 45);
    passwordField.placeholder = @"  Your password, please ;)";
    
    sendButton.hidden = YES;
    signinButton.hidden = NO;
    signup2Button.hidden = YES;
    signup1Button.hidden = NO;
    backButton.hidden = YES;
    forgetButton.hidden = NO;
}

- (IBAction) sendClicked:(id)sender {
    
    NSInteger success = 0;
    NSString *emailRegex = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    @try{
        if([[self.emailField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but please enter your email address!" :@"Failed to Get Password!" :0];
        }
        else if(![pred evaluateWithObject:[self.emailField text]])
        {
            [self alertStatus:@"Sorry, the email is not valid!" :@"Failed to Get Password!" :0];
        }
        else
        {
            NSDictionary *keyPair = @{@"email" : [self.emailField text]};
            NSDictionary *jsonData = [DataTransfer requestObjectWithURL:@"http://52.6.223.152:80/getPassword" httpMethod:@"POST" params:keyPair];
            
            if(jsonData == NULL)
            {
                [self alertStatus:@"Connection Failed" :@"Failed to Get Password!" :0];
            }
            else
            {
                success = [jsonData[@"getback"] integerValue];
                
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Get Password Back!");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Failed to Get Password!" :0];
                }
                
            }
            //success = 1;
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Failed to Get Password." :@"Error!" :0];
    }
    if (success == 1) {
        [self alertStatus:@"Your Password Has been Sent. Please Check Your Email!" :@"Success" :1];
    }

    
}

- (IBAction) forgetClicked:(id)sender {
    emailField.hidden = NO;
    emailField.frame = CGRectMake(self.view.frame.size.width/2-125, 270, 250, 45);
    usernameField.hidden = YES;
    passwordField.hidden = YES;
    backButton.frame = CGRectMake(self.view.frame.size.width/2+10, 420, 100, 45);
    backButton.hidden = NO;
    sendButton.hidden = NO;
    forgetButton.hidden = YES;
    signinButton.hidden = YES;
    signup1Button.hidden = YES;
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
