//
//  ProfileViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=210,149,41
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 画像を読み込み，指定色でレンダリング
    UIImage *img = [UIImage imageNamed:@"profile"];
    self.profileImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.profileImg setClipsToBounds:YES];
    self.view.tintColor = [UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0];
    self.profileImg.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
