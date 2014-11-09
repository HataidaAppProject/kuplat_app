//
//  HomeViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownMenuView.h"
#import "EventDetailViewController.h"
#import "RestaurantDetailViewController.h"
#import "EventItem.h"
#import "RestaurantItem.h"

typedef NS_ENUM(NSInteger, TrendImageTag) {
    TrendEventImageTag = 1,
    TrendRestaurantImageTag = 2
};

@interface HomeViewController : UIViewController <UIScrollViewDelegate, DropdownMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgTop;

//トレンド
@property (weak, nonatomic) IBOutlet UIImageView *imgTrendEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imgTrendRestaurant;
@property (strong, nonatomic) RestaurantItem *trendRestaurant;
@property (strong, nonatomic) EventItem *trendEvent;

//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)tappedMenuButton:(id)sender;

@end

