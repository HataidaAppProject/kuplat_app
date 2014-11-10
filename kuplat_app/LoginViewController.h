//
//  LoginViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/10.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginBotton;
@property (weak, nonatomic) IBOutlet UIButton *registrationBotton;

- (IBAction)pushLoginButton:(id)sender;
- (IBAction)pushRegistrationButton:(id)sender;

@end
