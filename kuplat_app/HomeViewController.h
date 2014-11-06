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

@interface HomeViewController : UIViewController <DropdownMenuViewDelegate>

//メニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

//トレンド
@property (weak, nonatomic) IBOutlet UIImageView *imgTrendEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imgTrendRestaurant;
@property (strong, nonatomic) RestaurantItem *trendRestaurant;
@property (strong, nonatomic) EventItem *trendEvent;

@end

