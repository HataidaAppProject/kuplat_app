//
//  EventDetailViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailView.h"
#import "EventItem.h"
#import "MenuView.h"

@interface EventDetailViewController : UIViewController <MenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) EventDetailView *contentView;

// 外部からの遷移時に情報を受け取る
@property (strong, nonatomic) EventItem *event;


//ドロップダウンメニュー
@property (strong, nonatomic) MenuView *menuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end