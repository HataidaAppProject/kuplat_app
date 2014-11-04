//
//  RestaurantDetailView.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/05.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantDetailView : UIView

// 各View
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIView *reviewView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
// イベント情報
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantType;
@property (weak, nonatomic) IBOutlet UILabel *restaurantScore;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCoupon;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;
@property (weak, nonatomic) IBOutlet UILabel *review;
@property (weak, nonatomic) IBOutlet UILabel *menuText;
@property (weak, nonatomic) IBOutlet UILabel *informationText;
@property (weak, nonatomic) IBOutlet UILabel *star1;
@property (weak, nonatomic) IBOutlet UILabel *star2;
@property (weak, nonatomic) IBOutlet UILabel *star3;
@property (weak, nonatomic) IBOutlet UILabel *star4;
@property (weak, nonatomic) IBOutlet UILabel *star5;
// 各ViewのConstraint(Viewを非表示にする際に使用)
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewBottomConstraint;

/**
 * レイアウト幅を設定
 */
- (void)setLayoutWidth:(CGFloat)width;

@property (weak, nonatomic) UIView *contentView;
@property (nonatomic) CGSize layoutSize;

@end
