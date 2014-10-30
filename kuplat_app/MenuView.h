//
//  MenuView.h
//  TopSlideMenuSample
//
//  Created by hiraya.shingo on 2014/03/19.
//  Copyright (c) 2014年 hiraya.shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuViewSelectedItemType) {
    MenuViewSelectedItemTypeAddRestaurant = 0,
    MenuViewSelectedItemTypeAddEvent,
    MenuViewSelectedItemTypeModifyUserInfo,
    MenuViewSelectedItemTypeCntact,
    MenuViewSelectedItemTypeAppInfo,
    MenuItemNum
};


@class MenuView;

@protocol MenuViewDelegate <NSObject>

- (void)menuViewDidSelectedItem:(MenuView *)menuView type:(MenuViewSelectedItemType)type;

@end


@interface MenuView : UIView

@property (weak, nonatomic) id<MenuViewDelegate> delegate;

@property (assign, nonatomic, readonly) BOOL isMenuOpen;

- (void)tappedMenuButton;

@end