//
//  AddRestaurantViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "AddRestaurantViewController.h"

@implementation AddRestaurantViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //タブ色の設定 rgb=190,82,36
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
}

@end
