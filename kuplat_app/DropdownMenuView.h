//
//  DropdownMenuView.h
//  TopSlideMenuSample
//
//  Created by hiraya.shingo on 2014/03/19.
//  Copyright (c) 2014年 hiraya.shingo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DropdownMenuViewSelectedItemType) {
    DropdownMenuViewSelectedItemTypeAddRestaurant = 0,
    DropdownMenuViewSelectedItemTypeAddEvent = 1,
    DropdownMenuViewSelectedItemTypeModifyUserInfo = 2,
    DropdownMenuViewSelectedItemTypeCntact = 3,
    DropdownMenuViewSelectedItemTypeAppInfo = 4,
    MenuItemNum = 5
};


@class DropdownMenuView;

@protocol DropdownMenuViewDelegate <NSObject>

- (void)dropdownMenuViewDidSelectedItem:(DropdownMenuView *)dropdownMenuView type:(DropdownMenuViewSelectedItemType)type;

@end


@interface DropdownMenuView : UIView

@property (weak, nonatomic) id<DropdownMenuViewDelegate> delegate;

@property (assign, nonatomic, readonly) BOOL isMenuOpen;

- (void)tappedMenuButton;
- (void)tappedMenuButtonWithOffset:(CGPoint)offset;

@end
