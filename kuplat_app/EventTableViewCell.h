//
//  EventTableViewCell.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/30.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventNumOfFavs;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventCost;
@property (weak, nonatomic) IBOutlet UILabel *eventPlace;

// マージンを調整する
@property (nonatomic) CGFloat insetH;
@property (nonatomic) CGFloat insetV;


@end
