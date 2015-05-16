//
//  SignUpViewController.h
//  Guideo
//
//  Created by 亮亮 李 on 15/5/16.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UILabel *greetlabel1;
@property (strong, nonatomic) UILabel *greetlabel2;
@property (strong, nonatomic) UILabel *greetlabel3;
@property (strong,nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UITextField *retypeField;
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UIButton *signupButton;

- (IBAction)signupClicked:(id)sender;
- (IBAction)backClicked:(id)sender;
- (IBAction)tapReturn:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag;
- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage;


@end
