//
//  RestaurantTableViewCell.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/04.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantScore;
@property (weak, nonatomic) IBOutlet UILabel *restaurantReview;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar1;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar2;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar3;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar4;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar5;

// マージンを調整する
@property (nonatomic) CGFloat insetH;
@property (nonatomic) CGFloat insetV;

@end
