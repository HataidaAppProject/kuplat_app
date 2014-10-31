//
//  RestaurantViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "RestaurantViewController.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController

- (void)viewWillAppear:(BOOL)animated {

    //タブ色の設定 rgb=190,82,36
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.745 green:0.322 blue:0.141 alpha:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RESTANRANT";
    /**********************************************************
     コンテンツのサイズを決める （オリジナルのフレームサイズじゃ駄目だった）
     **********************************************************/
    /*
    // オリジナルのフレームサイズ持っておく --> 縦横の値が逆になってる?? -->> willappearで宣言すればいいらしい
    // framesizeは
    self.originalFrameSize = CGSizeMake(self.scrollView.frame.size.height, self.scrollView.frame.size.width);
    //self.originalFrameSize = self.scrollView.frame.size;
    NSLog(@"オリジナル：幅%f，高さ%f", self.originalFrameSize.width, self.originalFrameSize.height);
     */
    // 画面サイズに準拠してコンテンツサイズを決める
    CGRect cr = [[UIScreen mainScreen] applicationFrame];
    //NSLog(@"ステータスバー領域を含まない画面サイズ：幅%f，高さ%f", cr.size.width, cr.size.height);
    self.originalFrameSize = CGSizeMake(cr.size.width,
                                          cr.size.height // ステータスパー除いた高さ
                                          - self.restaurantList1Button.frame.size.height // リスト選択ボタン
                                          - self.navigationController.navigationBar.frame.size.height // ナビゲーションバー
                                          - self.tabBarController.tabBar.frame.size.height); // タブ

    /************************************
     UIScrollView上に表示するコンテンツの準備
     ************************************/
    // UIScrollViewに表示するコンテンツViewを作成
    CGRect contentRect = CGRectMake(0, 0, self.originalFrameSize.width * 3, self.originalFrameSize.height);
    self.contentView = [[UIView alloc] initWithFrame:contentRect];
    // 3つのリストを作成
    UIView *subContent1View = [[UIView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * RestaurantList1, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    UIView *subContent2View = [[UIView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * RestaurantList2, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    UIView *subContent3View = [[UIView alloc] initWithFrame:CGRectMake(self.originalFrameSize.width * RestaurantList3, 0, self.originalFrameSize.width, self.originalFrameSize.height)];
    // とりあえず色分けしとく
    subContent1View.backgroundColor = [UIColor greenColor];
    subContent2View.backgroundColor = [UIColor blueColor];
    subContent3View.backgroundColor = [UIColor redColor];
    // 全部コンテンツViewに追加
    [self.contentView addSubview:subContent1View];
    [self.contentView addSubview:subContent2View];
    [self.contentView addSubview:subContent3View];
    // スクロールViewにコンテンツViewを追加
    [self.scrollView addSubview:self.contentView];
    
    
    /*************************
     UIScrollViewの表示設定を行う
     *************************/
    // スクロールView上のコンテンツViewのサイズを指定
    self.scrollView.contentSize = self.contentView.frame.size;
    // 初期表示するコンテンツViewの場所を指定する --> 一番左
    self.currentPage = RestaurantList2;
    self.scrollView.contentOffset = CGPointMake(self.originalFrameSize.width * self.currentPage, 0);
    self.scrollView.delegate = self;
    // ページングモード
    self.scrollView.pagingEnabled = YES;
    // スクロールバー消す
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    // コンテンツ境界でバウンドさせない
    self.scrollView.bounces = NO;
    
    /****************************************
     リストの遷移を追うナビゲータ (ボタンの裏に実装)
     ****************************************/
    // リスト選択ボタンと同じ大きさのView
    CGRect listNaviRect = CGRectMake(self.originalFrameSize.width/3 * self.currentPage, self.restaurantList1Button.frame.origin.y, self.originalFrameSize.width/3, self.restaurantList1Button.frame.size.height);
    self.restaurantListNaviView = [[UIView alloc] initWithFrame:listNaviRect];
    // 色
    self.restaurantListNaviView.backgroundColor = [UIColor colorWithRed:0.988 green:0.949 blue:0.922 alpha:1.0];
    // 再背面のサブViewとして追加
    [self.view addSubview:self.restaurantListNaviView];
    [self.view sendSubviewToBack:self.restaurantListNaviView];
    // リスト選択ボタンは透明にする
    self.restaurantList1Button.backgroundColor = [UIColor clearColor];
    self.restaurantList2Button.backgroundColor = [UIColor clearColor];
    self.restaurantList3Button.backgroundColor = [UIColor clearColor];
    
    
    
    /**************
     (未)リストの実装
     **************/
    
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅から，現在のページ番号を計算
    CGPoint offset = self.scrollView.contentOffset;
    NSInteger page = (offset.x + self.originalFrameSize.width/2) / self.originalFrameSize.width;

    // リストNavigatorをスクロールと共に動かす
    CGRect rect = self.restaurantListNaviView.frame;
    rect.origin.x = offset.x / 3;
    self.restaurantListNaviView.frame = rect;
    
    // ページが変わったら
    if (self.currentPage != page) {
        self.currentPage = page;
        [self didWhenChangingList];
    }
}

- (IBAction)restaurantList1BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * RestaurantList1;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (IBAction)restaurantList2BottonDidPush:(id)sender {

    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * RestaurantList2;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (IBAction)restaurantList3BottonDidPush:(id)sender {
    
    // スクロールViewを動かす
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.originalFrameSize.width * RestaurantList3;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

// リスト遷移時
- (void)didWhenChangingList {

    //NSLog(@"リスト遷移したったで");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
