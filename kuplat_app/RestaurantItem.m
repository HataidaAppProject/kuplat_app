//
//  RestaurantItem.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/05.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "RestaurantItem.h"

@implementation RestaurantItem

- (id) init
{
    self.image = [[UIImage alloc] init];
    self.name = [[NSString alloc] init];
    self.type = [[NSString alloc] init];
    self.score = [[NSString alloc] init];
    self.coupon= [[NSString alloc] init];
    self.address = [[NSString alloc] init];
    self.review = [[RestaurantReview alloc] init];
    self.menu = [[RestaurantMenu alloc] init];
    self.information = [[RestaurantInformation alloc] init];
    return self;
}

@end
