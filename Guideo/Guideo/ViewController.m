//
//  ViewController.m
//  Login
//
//  Created by 亮亮 李 on 15/4/5.
//  Copyright (c) 2015年 Kyran. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize greetlabel1, greetlabel2, usernameText, usernameField, passwordField, passwordText, signinButton, signupButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [greetlabel1 setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20.0]];
    [greetlabel2 setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20.0]];
    [usernameText setFont:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:18.0]];
    [passwordText setFont:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:18.0]];
    
    greetlabel1.textColor = [UIColor whiteColor];
    greetlabel2.textColor = [UIColor whiteColor];
    
    usernameText.textColor = [UIColor whiteColor];
    passwordText.textColor = [UIColor whiteColor];
    
    [usernameText setNeedsDisplay];
    [passwordText setNeedsDisplay];
    
    UIColor* textColor = [UIColor colorWithRed:(102.0/255.0) green:(197.0/255.0) blue:(245.0/255.0) alpha:1.0];
    [signinButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [signinButton setBackgroundColor: textColor];
    [signinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [signupButton setTitle:@"Sign up" forState:UIControlStateNormal];
    [signupButton setBackgroundColor: [UIColor whiteColor]];
    [signupButton setTitleColor:textColor forState:UIControlStateNormal];
    
    //    [signinButton setBackgroundImage:[UIImage imageNamed:@"signin.png"] forState:UIControlStateNormal];
    //    [signinButton setTitle:@"Sign in" forState:UIControlStateNormal];
    //    signinButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    passwordField.secureTextEntry = YES;
    greetlabel1.textColor = [UIColor whiteColor];
    greetlabel2.textColor = [UIColor whiteColor];
    //greetlabel1.textAlignment = NSTextAlignmentCenter;
    //greetlabel2.textAlignment = NSTextAlignmentCenter;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)signinDown:(id)sender {
    //[signinButton setBackgroundColor: [UIColor greenColor]];
    //    [signinButton setBackgroundImage:[UIImage imageNamed:@"signin_clicked.png"] forState:UIControlStateNormal];
    //    [signinButton setTitle:@"Sign in" forState:UIControlStateNormal];
    //    signinButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIColor* bgColor = [UIColor colorWithRed:(102.0/255.0) green:(210.0/255.0) blue:(255.0/255.0) alpha:1.0];
    [signinButton setBackgroundColor: bgColor];
    [signinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)signinClicked:(id)sender {
    //[signinButton setBackgroundColor: NULL];
    //    [signinButton setBackgroundImage:[UIImage imageNamed:@"signin.png"] forState:UIControlStateNormal];
    //    [signinButton setTitle:@"Sign in" forState:UIControlStateNormal];
    //    signinButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    // [signinButton setBackgroundColor: [UIColor whiteColor]];
    NSInteger success = 0;
    @try{
        if([[self.usernameField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but I don't know how to call you!" :@"Sign in failed!" :0];
        }
        else if([[self.passwordField text] isEqualToString:@""])
        {
            [self alertStatus:@"Sorry, but we should keep a secret words, right?" :@"Sign in failed!" :0];
        }
        else
        {
//            NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",[self.usernameField text],[self.passwordField text]];
//            NSLog(@"PostData: %@",post);
//            
//            NSURL *url=[NSURL URLWithString:@"http://52.6.223.152:80/login"];
//            
//            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//            
//            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//            
//            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//            [request setURL:url];
//            [request setHTTPMethod:@"POST"];
//            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//            //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//            
//            [request setHTTPBody:postData];
//            
//            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
//            
//            NSError *error;
//            NSHTTPURLResponse *response;
//            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//            
//            NSLog(@"Response code: %ld", (long)[response statusCode]);
//            
//            if ([response statusCode] >= 200 && [response statusCode] < 300)
//            {
//                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//                NSLog(@"Response ==> %@", responseData);
//                
//                NSError *error = nil;
//                NSDictionary *jsonData = [NSJSONSerialization
//                                          JSONObjectWithData:urlData
//                                          options:NSJSONReadingMutableContainers
//                                          error:&error];
//                
//                success = [jsonData[@"login"] integerValue];
//                NSLog(@"Success: %ld",(long)success);
//                
//                if(success == 1)
//                {
//                    NSLog(@"Login SUCCESS");
//                } else {
//                    
//                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
//                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
//                }
//                
//            } else {
//                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
//            }
             success = 1;
        }
        
    }
    @catch (NSException * e) {
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
