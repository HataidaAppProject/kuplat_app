//
//  RegistrationViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/10.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backgroundImageView setImage:[UIImage imageNamed:@"tokeidai.jpg"]];
    
    // ボタン枠とアンケート欄Viewの角を丸くする
    [self.sexSegmentedControl.layer setCornerRadius:5.0];
    [self.sexSegmentedControl setClipsToBounds:YES];
    [self.questionnaireFieldView.layer setCornerRadius:5.0];
    [self.questionnaireFieldView setClipsToBounds:YES];
    [self.registrationButton.layer setCornerRadius:5.0];
    [self.registrationButton setClipsToBounds:YES];
    [self.noticeLabel.layer setCornerRadius:5.0];
    [self.noticeLabel setClipsToBounds:YES];
    
    // 注意書きは非表示
    [self.noticeLabel setNumberOfLines:0];
    [self.noticeLabel setHidden:YES];
    
    // アンケートの項目の初期は未選択
    self.checkbox1_YES = NO;
    self.checkbox2_YES = NO;
    self.checkbox3_YES = NO;
    self.checkbox4_YES = NO;
    self.checkbox5_YES = NO;
    self.checkbox6_YES = NO;
    
    NSLog(@"AppName: %@", [[NSBundle mainBundle] bundlePath]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushRegistrationButton:(id)sender {
    
    if (self.userNameTextField.hasText && self.mailAddressTextField.hasText && self.studentIDTextField.hasText && self.departmentTextField.hasText && self.enteredYearTextField.hasText && self.clubField1.hasText && self.clubField2.hasText && self.clubField3.hasText)
    {
        
        // 認証ステータス
        BOOL certification = NO;
        
        // サーバへユーザ情報・アンケート情報の登録
        certification = YES; // 無理やり
        
        
        if (certification) {
            // ユーザ情報を持ってメイン画面へ遷移
            [self performSegueWithIdentifier:@"toMain" sender:self];
        }
        else
        {
            [self.noticeLabel setText:@"このメールアドレスは既に登録済みです"];
            [self.noticeLabel setHidden:NO];
        }
    }
    else
    {
        [self.noticeLabel setText:@"すべての項目を入力してください"];
        [self.noticeLabel setHidden:NO];
    }
    
    
}


// アンケートボタン
- (IBAction)pushCheckbox1:(id)sender {
    
    if (self.checkbox1_YES)
    {
        [self.checkbox1 setImage:[UIImage imageNamed:@"checkboxF"] forState:UIControlStateNormal];
        self.checkbox1_YES = NO;
    }
    else
    {
        [self.checkbox1 setImage:[UIImage imageNamed:@"checkboxT"] forState:UIControlStateNormal];
        self.checkbox1_YES = YES;
    }
}

- (IBAction)pushCheckbox2:(id)sender {
    
    if (self.checkbox2_YES)
    {
        [self.checkbox2 setImage:[UIImage imageNamed:@"checkboxF"] forState:UIControlStateNormal];
        self.checkbox2_YES = NO;
    }
    else
    {
        [self.checkbox2 setImage:[UIImage imageNamed:@"checkboxT"] forState:UIControlStateNormal];
        self.checkbox2_YES = YES;
    }
}

- (IBAction)pushCheckbox3:(id)sender {
    
    if (self.checkbox3_YES)
    {
        [self.checkbox3 setImage:[UIImage imageNamed:@"checkboxF"] forState:UIControlStateNormal];
        self.checkbox3_YES = NO;
    }
    else
    {
        [self.checkbox3 setImage:[UIImage imageNamed:@"checkboxT"] forState:UIControlStateNormal];
        self.checkbox3_YES = YES;
    }
}

- (IBAction)pushCheckbox4:(id)sender {
    
    if (self.checkbox4_YES)
    {
        [self.checkbox4 setImage:[UIImage imageNamed:@"checkboxF"] forState:UIControlStateNormal];
        self.checkbox4_YES = NO;
    }
    else
    {
        [self.checkbox4 setImage:[UIImage imageNamed:@"checkboxT"] forState:UIControlStateNormal];
        self.checkbox4_YES = YES;
    }
}

- (IBAction)pushCheckbox5:(id)sender {
    
    if (self.checkbox5_YES)
    {
        [self.checkbox5 setImage:[UIImage imageNamed:@"checkboxF"] forState:UIControlStateNormal];
        self.checkbox5_YES = NO;
    }
    else
    {
        [self.checkbox5 setImage:[UIImage imageNamed:@"checkboxT"] forState:UIControlStateNormal];
        self.checkbox5_YES = YES;
    }
}

- (IBAction)pushCheckbox6:(id)sender {
    
    if (self.checkbox6_YES)
    {
        [self.checkbox6 setImage:[UIImage imageNamed:@"checkboxF"] forState:UIControlStateNormal];
        self.checkbox6_YES = NO;
    }
    else
    {
        [self.checkbox6 setImage:[UIImage imageNamed:@"checkboxT"] forState:UIControlStateNormal];
        self.checkbox6_YES = YES;
    }
}
@end
