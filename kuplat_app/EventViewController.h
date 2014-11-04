//
//  EventViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"

typedef NS_ENUM(NSInteger, MenuViewSelectedItemType) {
    EventList1 = 0,
    EventList2 = 1,
    EventList3 = 2,
    EventListsNum = 3
};

@interface EventViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>


// リストに表示するアイテムを格納
@property(strong, nonatomic) NSMutableArray *menuItems;
// リスト
@property(strong, nonatomic) UITableView *eventTableView1;
@property(strong, nonatomic) UITableView *eventTableView2;
@property(strong, nonatomic) UITableView *eventTableView3;


// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// リスト選択ボタン
@property (weak, nonatomic) IBOutlet UIButton *eventList1Button;
@property (weak, nonatomic) IBOutlet UIButton *eventList2Button;
@property (weak, nonatomic) IBOutlet UIButton *eventList3Button;
// リスト遷移を追うナビゲータ
@property (strong, nonatomic) UIView *eventListNaviView;

// 横長のView
@property (strong, nonatomic) UIView *contentView;
// スクロールに指定するviewのサイズ
@property (nonatomic) CGSize originalFrameSize;
// ページ番号
@property (nonatomic) NSInteger currentPage;


@end

