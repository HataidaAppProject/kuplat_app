//
//  EventDetailViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventItem.h"
#import "DropdownMenuView.h"

@interface EventDetailViewController : UIViewController <DropdownMenuViewDelegate>

// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// 各View
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
// イベント情報
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventNumOfFav;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventCost;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UILabel *eventAbout;
@property (weak, nonatomic) IBOutlet UILabel *eventInformation;
// 各ViewのConstraint(Viewを非表示にする際に使用)
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutViewBottomConstraint;


// 外部からの遷移時に情報を受け取る
@property (strong, nonatomic) EventItem *event;


//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end