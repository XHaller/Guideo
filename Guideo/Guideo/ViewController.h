//
//  ViewController.h
//  Login
//
//  Created by 亮亮 李 on 15/4/5.
//  Copyright (c) 2015年 Kyran. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UILabel *greetlabel1;
@property (strong, nonatomic) UILabel *greetlabel2;
@property (strong, nonatomic) UILabel *greetlabel3;
@property (strong,nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UITextField *retypeField;
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *signinButton;
@property (strong, nonatomic)UIButton *signup1Button;
@property (strong, nonatomic)UIButton *signup2Button;
@property (strong, nonatomic)UIButton *forgetButton;


- (IBAction)signinClicked:(id)sender;
- (IBAction)signup1Clicked:(id)sender;
- (IBAction)signup2Clicked:(id)sender;
- (IBAction)forgetClicked:(id)sender;
- (IBAction)sendClicked:(id)sender;
- (IBAction)backClicked:(id)sender;
- (IBAction)tapReturn:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag;
- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage;

@end

