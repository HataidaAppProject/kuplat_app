//
//  EventDetailView.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailView : UIView

// 各View
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
// イベント情報
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventDateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *eventCost;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UILabel *aboutText;
@property (weak, nonatomic) IBOutlet UILabel *informationText;
// 各ViewのConstraint(Viewを非表示にする際に使用)
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutViewBottomConstraint;


@property (weak, nonatomic) UIView *contentView;
@property (nonatomic) CGSize layoutSize;

/**
 * レイアウト幅を設定
 */
- (void)setLayoutWidth:(CGFloat)width;


@end