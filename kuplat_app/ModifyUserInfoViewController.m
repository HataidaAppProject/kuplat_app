//
//  ModifyUserInfoViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "ModifyUserInfoViewController.h"

@implementation ModifyUserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=210,149,41
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.824 green:0.584 blue:0.161 alpha:1.0]];
}


@end
