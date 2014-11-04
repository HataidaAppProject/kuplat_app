//
//  EventDetailViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //タブ色の設定 rgb=74,133,34
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];

    //タブ色の設定 遷移元のviewWillAppearを呼び出す
    //NSInteger index = [self.navigationController.viewControllers count];
    //UIViewController *parent = [self.navigationController.viewControllers objectAtIndex:index-2];
    //[parent viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"イベント詳細"];
    
    // スクロールの中身となるViewの生成
    self.contentView = [[EventDetailView alloc] initWithFrame:self.scrollView.bounds];
    // Constraintは自分で設定するのでNO
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Subviewとして追加
    [self.scrollView addSubview:self.contentView];
    
    // Constraintの設定
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scrollView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0f
                                                             constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scrollView
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0f
                                                             constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scrollView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0f
                                                             constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.scrollView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0f
                                                             constant:0]];
    
    //アスペクト比を保ったままサイズ調整
    UIScreen *sc = [UIScreen mainScreen];
    [self.contentView.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView.imageView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:0.0
                                                                        constant:sc.applicationFrame.size.width - 16]];
    [self.contentView.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView.imageView setClipsToBounds:YES];
    [self.contentView.imageView setImage:[UIImage imageNamed:@"SampleTrendEvent"]];
    
    [self.contentView.eventNumOfFav setText:@"10名"];
    [self.contentView.eventDate setText:@"2014.11.20"];
    [self.contentView.eventCost setText:@"1,000円"];
    [self.contentView.eventAddress setText:@"京大グラウンド"];
    
    [self.contentView.aboutText setNumberOfLines:0];
    [self.contentView.aboutText setText:@"毎年恒例のなんちゃらかんちゃらhugahugafogehoge"];
    
    [self.contentView.informationText setNumberOfLines:0];
    [self.contentView.informationText setText:@"テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト"];
    
    
    /**********************
      アイテムの非表示化(map)
     **********************/
    /*
    // viewの非表示化
    _contentView.mapView.hidden = NO;
    // viewの高さを0にする
    [_contentView.mapView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView.mapView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:1.0f
                                                                      constant:0.0f]];
    // 直下viewとのマージンを0にする
    _contentView.mapViewBottomConstraint.constant = 0.0f;
     */

}

// 画面表示される時や画面回転した後に呼ばれる
- (void)viewDidLayoutSubviews
{
    [self.contentView setLayoutWidth:self.scrollView.frame.size.width];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end