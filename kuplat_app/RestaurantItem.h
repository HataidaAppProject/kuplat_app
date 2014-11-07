//
//  RestaurantItem.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/05.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RestaurantInformation.h"
#import "RestaurantReview.h"
#import "RestaurantMenu.h"

@interface RestaurantItem : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *score;
@property (nonatomic) NSString *coupon;
@property (nonatomic) NSString *address;
@property (nonatomic) CGFloat latitude;  //緯度
@property (nonatomic) CGFloat longitude; //経度
@property (nonatomic) RestaurantReview *review;  //後で配列に
@property (nonatomic) RestaurantMenu *menu;  //後で配列に
@property (nonatomic) RestaurantInformation *information;

@end
