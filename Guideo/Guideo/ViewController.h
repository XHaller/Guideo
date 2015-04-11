//
//  ViewController.h
//  Login
//
//  Created by 亮亮 李 on 15/4/5.
//  Copyright (c) 2015年 Kyran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *greetlabel1;
@property (nonatomic, weak) IBOutlet UILabel *greetlabel2;
@property (weak, nonatomic) IBOutlet UILabel *usernameText;
@property (nonatomic, weak) IBOutlet UILabel *passwordText;
@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;
@property (nonatomic, weak) IBOutlet UIButton *signupButton;

- (IBAction)signinDown:(id)sender;
- (IBAction)signinClicked:(id)sender;
- (IBAction)tapReturn:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag;

@end

