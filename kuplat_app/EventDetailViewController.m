//
//  EventDetailViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventDetailViewController.h"
#import "EventDetailView.h"

@interface EventDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) EventDetailView *contentView;

@end

@implementation EventDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=74,133,34
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.290 green:0.522 blue:0.133 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"イベント詳細";
    
    // スクロールの中身となるView（STVerticalScrollContentView）の生成
    _contentView = [[EventDetailView alloc] initWithFrame:self.scrollView.bounds];
    // Constraintは自分で設定するのでNO
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    // Subviewとして追加
    [_scrollView addSubview:_contentView];
    //
    // Constraintの設定。
    // STVerticalScrollContentViewの上下左右の間隔0pxとする
    //
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0f
                                                             constant:0]];
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0f
                                                             constant:0]];
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0f
                                                             constant:0]];
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0f
                                                             constant:0]];
    
    //アスペクト比を保ったままサイズ調整
    _contentView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_contentView.imageView setClipsToBounds:YES];
    _contentView.imageView.image = [UIImage imageNamed:@"SampleTrendEvent"];
    _contentView.informationText.text = @"テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト";
    
    
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

// 画面表示される時や画面回転した後に、
// viewDidLayoutSubviewsが呼ばれる
- (void)viewDidLayoutSubviews
{
    [_contentView setLayoutWidth:_scrollView.frame.size.width];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end