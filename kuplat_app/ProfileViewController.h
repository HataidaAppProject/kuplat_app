//
//  ProfileViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownMenuView.h"
#import "EventItem.h"
#import "RestaurantItem.h"
#import "EventDetailViewController.h"
#import "RestaurantDetailViewController.h"
#import "EventTableViewCell.h"
#import "RestaurantTableViewCell.h"

typedef NS_ENUM(NSInteger, FavoriteCellTag) {
    FavoriteEventCellTag = 1,
    FavoriteRestaurantCellTag = 2
};

@interface ProfileViewController : UIViewController <DropdownMenuViewDelegate, UITableViewDataSource, UITableViewDelegate>

// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImg;

@property (nonatomic) EventItem *sendEvent;
@property (nonatomic) RestaurantItem *sendRestaurant;

@property (weak, nonatomic) IBOutlet UITableView *favEventTableView;
@property(strong, nonatomic) NSMutableArray *eventsItems;

@property (weak, nonatomic) IBOutlet UITableView *favRestaurantTableView;
@property(strong, nonatomic) NSMutableArray *restaurantsItems;

//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)tappedMenuButton:(id)sender;

@end

