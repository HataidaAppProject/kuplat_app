//
//  RegistrationViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/10.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+EKKeyboardAvoiding.h"

@interface RegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *studentIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *departmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *enteredYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *clubField1;
@property (weak, nonatomic) IBOutlet UITextField *clubField2;
@property (weak, nonatomic) IBOutlet UITextField *clubField3;
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

//@property (strong)
@property (weak, nonatomic) IBOutlet UIView *questionnaireFieldView;
@property (weak, nonatomic) IBOutlet UIButton *checkbox1;
@property (weak, nonatomic) IBOutlet UIButton *checkbox2;
@property (weak, nonatomic) IBOutlet UIButton *checkbox3;
@property (weak, nonatomic) IBOutlet UIButton *checkbox4;
@property (weak, nonatomic) IBOutlet UIButton *checkbox5;
@property (weak, nonatomic) IBOutlet UIButton *checkbox6;
- (IBAction)pushCheckbox1:(id)sender;
- (IBAction)pushCheckbox2:(id)sender;
- (IBAction)pushCheckbox3:(id)sender;
- (IBAction)pushCheckbox4:(id)sender;
- (IBAction)pushCheckbox5:(id)sender;
- (IBAction)pushCheckbox6:(id)sender;
@property (nonatomic) BOOL checkbox1_YES;
@property (nonatomic) BOOL checkbox2_YES;
@property (nonatomic) BOOL checkbox3_YES;
@property (nonatomic) BOOL checkbox4_YES;
@property (nonatomic) BOOL checkbox5_YES;
@property (nonatomic) BOOL checkbox6_YES;





@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)pushRegistrationButton:(id)sender;

@end
