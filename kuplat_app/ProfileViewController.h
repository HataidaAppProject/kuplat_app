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

typedef NS_ENUM(NSInteger, FavoriteCellTag) {
    FavoriteEventCellTag = 1,
    FavoriteRestaurantCellTag = 2
};

@interface ProfileViewController : UIViewController <DropdownMenuViewDelegate>

// スクロールView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImg;

@property (nonatomic) EventItem *favEvent;
@property (weak, nonatomic) IBOutlet UIView *favRestaurantView;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventNumOfFavs;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventPlace;
@property (weak, nonatomic) IBOutlet UILabel *eventCost;

@property (nonatomic) RestaurantItem *favRestaurant;
@property (weak, nonatomic) IBOutlet UIView *favEventView;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantScore;
@property (weak, nonatomic) IBOutlet UILabel *restaurantReview;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar1;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar2;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar3;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar4;
@property (weak, nonatomic) IBOutlet UILabel *restaurantStar5;


//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)tappedMenuButton:(id)sender;

@end

