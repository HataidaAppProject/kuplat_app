//
//  RestaurantViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuViewSelectedItemType) {
    RestaurantList1 = 0,
    RestaurantList2 = 1,
    RestaurantList3 = 2,
    RestaurantListsNum = 3
};

@interface RestaurantViewController : UIViewController <UIScrollViewDelegate> {}

// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// リスト選択ボタン
@property (weak, nonatomic) IBOutlet UIButton *restaurantList1Button;
@property (weak, nonatomic) IBOutlet UIButton *restaurantList2Button;
@property (weak, nonatomic) IBOutlet UIButton *restaurantList3Button;
// リスト遷移を追うナビゲータ
@property (strong, nonatomic) UIView *restaurantListNaviView;

// 横長のView
@property (strong, nonatomic) UIView *contentView;
// スクロールに指定するviewのサイズ
@property (nonatomic) CGSize originalFrameSize;
// ページ番号
@property (nonatomic) NSInteger currentPage;



- (void)scrollViewDidScroll:(UIScrollView *)sender;
- (IBAction)restaurantList1BottonDidPush:(id)sender;
- (IBAction)restaurantList2BottonDidPush:(id)sender;
- (IBAction)restaurantList3BottonDidPush:(id)sender;
- (void)didWhenChangingList;


/**
  *  サムネイル・デバイス名・セル番号で構成されたカスタムセルのIDです。
  */
//static NSString * const RestaurantTableViewCustomCellIdentifier = @"RestaurantTableCell";

@end

