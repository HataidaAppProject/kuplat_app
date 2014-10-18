//
//  HomeViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*****************
       ホーム画面上部
    *****************/
    
    
    /*****************
       ホーム画面下部
    *****************/
    //タップを有効化
    _imgTrendEvent.userInteractionEnabled = YES;
    _imgTrendRestaurant.userInteractionEnabled = YES;
    //タグを設定
    _imgTrendEvent.tag = 1;
    _imgTrendRestaurant.tag = 2;
    //アスペクト比を保ったままサイズ調整
    _imgTrendEvent.contentMode = UIViewContentModeScaleAspectFill;
    [_imgTrendEvent setClipsToBounds:YES];
    _imgTrendRestaurant.contentMode = UIViewContentModeScaleAspectFill;
    [_imgTrendRestaurant setClipsToBounds:YES];
    //画像を指定
    _imgTrendEvent.image = [UIImage imageNamed: @"SampleTrendEvent"];
    _imgTrendRestaurant.image = [UIImage imageNamed: @"SampleTrendRestaurant"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pagingAction:(id)sender {
}
@end
