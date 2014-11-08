//
//  RestaurantViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantTableViewCell.h"
#import "RestaurantDetailViewController.h"
#import "RestaurantItem.h"
#import "DropdownMenuView.h"

typedef NS_ENUM(NSInteger, RestaurantListType) {
    RestaurantList1 = 0,
    RestaurantList2 = 1,
    RestaurantList3 = 2,
    RestaurantList4 = 3,
    RestaurantList5 = 4,
    RestaurantListsNum = 5
};

@interface RestaurantViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, DropdownMenuViewDelegate>

// リストに表示するアイテムを格納
@property(strong, nonatomic) NSMutableArray *restaurantsItems1;
@property(strong, nonatomic) NSMutableArray *restaurantsItems2;
@property(strong, nonatomic) NSMutableArray *restaurantsItems3;
@property(strong, nonatomic) NSMutableArray *restaurantsItems4;
@property(strong, nonatomic) NSMutableArray *restaurantsItems5;
// リスト
@property(strong, nonatomic) UITableView *restaurantTableView1;
@property(strong, nonatomic) UITableView *restaurantTableView2;
@property(strong, nonatomic) UITableView *restaurantTableView3;
@property(strong, nonatomic) UITableView *restaurantTableView4;
@property(strong, nonatomic) UITableView *restaurantTableView5;
// 詳細Viewへ渡すEventアイテム
@property (strong, nonatomic) RestaurantItem *sendRestaurant;


// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// リスト選択ボタン
@property (weak, nonatomic) IBOutlet UIButton *restaurantList1Button;
@property (weak, nonatomic) IBOutlet UIButton *restaurantList2Button;
@property (weak, nonatomic) IBOutlet UIButton *restaurantList3Button;
@property (weak, nonatomic) IBOutlet UIButton *restaurantList4Button;
@property (weak, nonatomic) IBOutlet UIButton *restaurantList5Button;
// リスト遷移を追うナビゲータ
@property (strong, nonatomic) UIView *restaurantListNaviView;

// 横長のView
@property (strong, nonatomic) UIView *contentView;
// スクロールに指定するviewのサイズ
@property (nonatomic) CGSize originalFrameSize;
// ページ番号
@property (nonatomic) NSInteger currentPage;


//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

