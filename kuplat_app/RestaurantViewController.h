//
//  RestaurantViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuViewSelectedItemType) {
    RestaurantList1 = 0,
    RestaurantList2 = 1,
    RestaurantList3 = 2,
    RestaurantListsNum = 3
};

@interface RestaurantViewController : UIViewController <UIScrollViewDelegate> {}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property UIView *contentView;
@property CGSize originalFrameSize;
@property NSInteger currentPage;

- (void)doWhenPagingOccurred;

//- (IBAction)changePage:(id)sender;

/**
  *  サムネイル・デバイス名・セル番号で構成されたカスタムセルのIDです。
  */
//static NSString * const RestaurantTableViewCustomCellIdentifier = @"RestaurantTableCell";

@end

