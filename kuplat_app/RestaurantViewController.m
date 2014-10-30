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
    
    /**********************************************************
     コンテンツのサイズを決める （オリジナルのフレームサイズじゃ駄目だった）
     **********************************************************/
    /*
    // オリジナルのフレームサイズ持っておく --> 縦横の値が逆になってる??
    self.originalFrameSize = CGSizeMake(self.scrollView.frame.size.height, self.scrollView.frame.size.width);
    //self.originalFrameSize = self.scrollView.frame.size;
    NSLog(@"オリジナル：幅%f，高さ%f", self.originalFrameSize.width, self.originalFrameSize.height);
     */
    // 画面サイズに準拠してコンテンツサイズを決める
    CGRect cr = [[UIScreen mainScreen] applicationFrame];
    //NSLog(@"ステータスバー領域を含まない画面サイズ：幅%f，高さ%f", cr.size.width, cr.size.height);
    self.originalFrameSize = CGSizeMake(cr.size.width,
                                          cr.size.height // ステータスパー除いた高さ
                                          - self.pageControl.frame.size.height // リスト選択する部分
                                          - self.navigationController.navigationBar.frame.size.height // ナビゲーションバー
                                          - self.tabBarController.tabBar.frame.size.height); // タブ
    
    /************************************
     UIScrollView上に表示するコンテンツの準備
     ************************************/
    // UIScrollViewに表示するコンテンツViewを作成する。
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
    self.currentPage = RestaurantList1;
    self.scrollView.contentOffset = CGPointMake(self.originalFrameSize.width * self.currentPage, 0);
    self.scrollView.delegate = self;
    // ページングモード
    self.scrollView.pagingEnabled = YES;
    // スクロールバー消す
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    
    // ページ数
    self.pageControl.numberOfPages = RestaurantListsNum;
    self.pageControl.currentPage = self.currentPage;
    
    
    /**************
     (未)リストの実装
     **************/
    
    
    
    /********************
     (未)リスト選択部の実装
     ********************/

    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅から，現在のページ番号を計算
    CGPoint offset = self.scrollView.contentOffset;
    NSInteger page = (offset.x + self.originalFrameSize.width/2) / self.originalFrameSize.width;
    // ページが変わったら
    if (self.currentPage != page) {
        self.currentPage = page;
        [self doWhenPagingOccurred];
    }
}

- (void)doWhenPagingOccurred {

    // ページコントローラの表示変える
    self.pageControl.currentPage = self.currentPage;
    
    /*************************
     (未)選択済みリストを切り替える
     *************************/

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
