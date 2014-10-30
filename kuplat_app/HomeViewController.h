//
//  HomeViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import "EventDetailViewController.h"

@interface HomeViewController : UIViewController <MenuViewDelegate>

//メニュー
@property (strong, nonatomic) MenuView *menuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

//トレンド
@property (weak, nonatomic) IBOutlet UIImageView *imgTrendEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imgTrendRestaurant;



@end

