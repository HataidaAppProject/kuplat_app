//
//  DropdownMenuView.m
//  TopSlideMenuSample
//
//  Created by hiraya.shingo on 2014/03/19.
//  Copyright (c) 2014年 hiraya.shingo. All rights reserved.
//

#import "DropdownMenuView.h"

@interface DropdownMenuView ()

@property (assign, nonatomic, readwrite) BOOL isMenuOpen;

@end

@implementation DropdownMenuView

#pragma mark - UIView methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //NSLog(@"awakeFromNib");
    CGRect menuFrame = self.frame;
    menuFrame.origin.y = menuFrame.origin.y;

    // set initial value
    self.isMenuOpen = NO;
}

#pragma mark - public methods

- (void)tappedMenuButton
{
    //NSLog(@"DropdownMenuView - tappedMenuButton");
    
    if (self.isMenuOpen) {
        [self closeDropdownMenuView];
    } else {
        [self openDropdownMenuView];
    }
}

#pragma mark - private methods

/**
 *  close DropdownMenuView
 */
- (void)closeDropdownMenuView
{
    //NSLog(@"closeDropdownMenuView");
    // Set new origin of menu
    CGRect menuFrame = self.frame;
    menuFrame.origin.y = menuFrame.origin.y - self.frame.size.height;
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = menuFrame;
                     }
                     completion:^(BOOL finished){
                         self.isMenuOpen = NO;
                     }];
    
    [UIView commitAnimations];
}

/**
 *  open DropdownMenuView
 */
- (void)openDropdownMenuView
{
    //NSLog(@"openDropdownMenuView");
    // Set new origin of menu
    CGRect menuFrame = self.frame;
    menuFrame.origin.y = menuFrame.origin.y + self.frame.size.height;
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = menuFrame;
                     }
                     completion:^(BOOL finished){
                         self.isMenuOpen = YES;
                     }];
    
    [UIView commitAnimations];
}

- (void)tappedButtonWithType:(DropdownMenuViewSelectedItemType)type
{
    if ([self.delegate respondsToSelector:@selector(dropdownMenuViewDidSelectedItem:type:)]) {
        
        switch (type) {
            case DropdownMenuViewSelectedItemTypeAddRestaurant:
            {
                //NSLog(@"ここでも");
                break;
            }
            case DropdownMenuViewSelectedItemTypeAddEvent:
                
                break;
                
            case DropdownMenuViewSelectedItemTypeModifyUserInfo:
                
                break;
                
            case DropdownMenuViewSelectedItemTypeCntact:
                
                break;
                
            case DropdownMenuViewSelectedItemTypeAppInfo:
                
                break;
                
            default:
                break;
        }
        [self.delegate dropdownMenuViewDidSelectedItem:self type:type];
    }
    [self closeDropdownMenuView];
}

#pragma mark - Action methods

- (IBAction)tappedAddRestaurantButton:(id)sender {
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeAddRestaurant];
}

- (IBAction)tappedAddEventButton:(id)sender
{
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeAddEvent];
}

- (IBAction)tappedModifyUserInfoButton:(id)sender
{
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeModifyUserInfo];
}

- (IBAction)tappedContactButton:(id)sender
{
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeCntact];
}

- (IBAction)tappedAppInfoButton:(id)sender
{
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeAppInfo];
}

@end
