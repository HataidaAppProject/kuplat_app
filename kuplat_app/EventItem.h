//
//  EventItem.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/06.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EventInformation.h"

@interface EventItem : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *numOfFav;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *cost;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *aboutText;
@property (nonatomic) EventInformation *information;
@property (nonatomic) CGFloat latitude;  //緯度
@property (nonatomic) CGFloat longitude; //経度

@end