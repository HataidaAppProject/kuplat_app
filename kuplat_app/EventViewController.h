//
//  EventViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailViewController.h"
#import "EventTableViewCell.h"

@interface EventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//リストに表示するアイテムを格納
@property(strong, nonatomic) NSMutableArray *menuItems;

@end

