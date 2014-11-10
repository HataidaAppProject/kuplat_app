//
//  LoginViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/10.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.backgroundImageView setImage:[UIImage imageNamed:@"tokeidai.jpg"]];
    
    // ボタン枠と角を丸くする
    [self.loginBotton.layer setCornerRadius:5.0];
    [self.loginBotton setClipsToBounds:YES];
    [self.registrationBotton.layer setCornerRadius:5.0];
    [self.registrationBotton setClipsToBounds:YES];
    [self.noticeLabel.layer setCornerRadius:5.0];
    [self.noticeLabel setClipsToBounds:YES];
    
    // 注意書きは非表示
    [self.noticeLabel setNumberOfLines:0];
    [self.noticeLabel setHidden:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pushLoginButton:(id)sender {
    
    if (self.mailAddressTextField && self.passwordTextField.hasText) {
        
        // 認証ステータス
        BOOL certification = NO;
        
        // ユーザ情報をサーバで取得
        certification = YES; //無理やり
        
        

        if (certification) {
            // ユーザ情報を持ってメイン画面へ遷移
            [self performSegueWithIdentifier:@"toMain" sender:self];
        }
        else
        {
            [self.noticeLabel setHidden:NO];
            [self.noticeLabel setText:@"メールアドレスもしくはパスワードに誤りがあります"];
        }
    }
    else
    {
        [self.noticeLabel setHidden:NO];
        [self.noticeLabel setText:@"ユーザ名とメールアドレスを入力してください"];
    }
    
}

- (IBAction)pushRegistrationButton:(id)sender {
    [self performSegueWithIdentifier:@"toRegistraitonViewController" sender:self];
}

- (IBAction)loginViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
}
@end
