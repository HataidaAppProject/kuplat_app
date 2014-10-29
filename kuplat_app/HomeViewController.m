//
//  HomeViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "HomeViewController.h"
#import "EventDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=0,0,0
    [self.tabBarController.tabBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}


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
    
    // 戻るボタンを変更
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"HOME"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    self.navigationItem.backBarButtonItem = btn;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 1:
        {
            // イベント詳細へ遷移
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
            EventDetailViewController *con = [sb instantiateInitialViewController];

            // EVENTタブのViewControllerを取得する
            UINavigationController *vc = self.tabBarController.viewControllers[1];
            // EVENTタブを選択済みにする
            self.tabBarController.selectedViewController = vc;
            // UINavigationControllerに追加済みのViewを一旦取り除く
            [vc popToRootViewControllerAnimated:NO];
            // EVENTViewの画面遷移処理を呼び出す
            [vc pushViewController:con animated:YES];
            
            break;
        }
        case 2:
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
