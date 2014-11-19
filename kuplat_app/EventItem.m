//
//  EventItem.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/06.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventItem.h"

@implementation EventItem

- (id)init
{
    self.title = [[NSString alloc] init];
    self.numOfFav = [[NSString alloc] init];
    self.date = [[NSString alloc] init];
    self.cost = [[NSString alloc] init];
    self.address = [[NSString alloc] init];
    self.aboutText = [[NSString alloc] init];
    self.information = [[EventInformation alloc] init];
    return self;
}

@end
