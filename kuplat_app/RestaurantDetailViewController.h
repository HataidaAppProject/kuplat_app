//
//  RestaurantDetailViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/05.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailView.h"
#import "RestaurantItem.h"
#import <QuartzCore/QuartzCore.h> //viewの枠線用

@interface RestaurantDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) RestaurantDetailView *contentView;
@property (strong, nonatomic) RestaurantItem *restaurant;

@end
