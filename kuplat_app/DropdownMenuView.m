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
//topがscrollview用
- (void)tappedMenuButtonWithOffset:(CGPoint)offset
{
    //NSLog(@"DropdownMenuView - tappedMenuButton");
    
    if (self.isMenuOpen) {
        [self closeDropdownMenuViewWithOffset:offset];
    } else {
        [self openDropdownMenuViewWithOffset:offset];
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
    [UIView animateWithDuration:0.3
                          delay:0.05
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = menuFrame;
                     }
                     completion:^(BOOL finished){
                         self.isMenuOpen = NO;
                     }];
    
    [UIView commitAnimations];
}
- (void)closeDropdownMenuViewWithOffset:(CGPoint)offset
{
    // ちょと遅いけど
    CGRect menuFrame = self.frame;
    menuFrame.origin.y = menuFrame.origin.y - self.frame.size.height - offset.y;
    [UIView animateWithDuration:0.3 * (self.frame.size.height + offset.y) / self.frame.size.height
                          delay:0.05
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
    
    [UIView animateWithDuration:0.3
                          delay:0.05
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = menuFrame;
                     }
                     completion:^(BOOL finished){
                         self.isMenuOpen = YES;
                     }];
    
    [UIView commitAnimations];
}
- (void)openDropdownMenuViewWithOffset:(CGPoint)offset
{
    // オフセットの分だけ下げる
    CGRect menuFrame = self.frame;
    menuFrame.origin.y = menuFrame.origin.y + offset.y;
    self.frame = menuFrame;
    
    // 可視部分はそのまま
    [self openDropdownMenuView];
    
    [UIView commitAnimations];
}

- (void)tappedButtonWithType:(DropdownMenuViewSelectedItemType)type
{
    if ([self.delegate respondsToSelector:@selector(dropdownMenuViewDidSelectedItem:type:)]) {
        
        switch (type) {
            case DropdownMenuViewSelectedItemTypeAddEvent:
            {
                
                // EVENTタブを選択済にする
                UINavigationController *eventTabViewController = self.tabBarController.viewControllers[1];
                self.tabBarController.selectedViewController = eventTabViewController;
                [eventTabViewController popToRootViewControllerAnimated:NO];
                // Event追加へ遷移
                [eventTabViewController.viewControllers[0] performSegueWithIdentifier:@"toAddEventViewController" sender:nil];
                break;
            }
            case DropdownMenuViewSelectedItemTypeAddRestaurant:
            {
                
                // RESTAURANTタブを選択済にする
                UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
                self.tabBarController.selectedViewController = restaurantTabViewController;
                [restaurantTabViewController popToRootViewControllerAnimated:NO];
                // Restaurant追加へ遷移
                [restaurantTabViewController.viewControllers[0] performSegueWithIdentifier:@"toAddRestaurantViewController" sender:nil];
                break;
            }
            case DropdownMenuViewSelectedItemTypeModifyUserInfo:
            {
                
                // PROFILEタブを選択済にする
                UINavigationController *profileTabViewController = self.tabBarController.viewControllers[4];
                self.tabBarController.selectedViewController = profileTabViewController;
                [profileTabViewController popToRootViewControllerAnimated:NO];
                // 登録情報変更へ遷移
                [profileTabViewController.viewControllers[0] performSegueWithIdentifier:@"toModifyUserInfoViewController" sender:nil];
                break;
            }
            case DropdownMenuViewSelectedItemTypeCntact:
            {
                
                CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController
                                                                    controllerWithTopics:CTFeedbackViewController.defaultTopics
                                                                    localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];

                feedbackViewController.toRecipients = @[@"ctfeedback@example.com"];
                [self.navigationController pushViewController:feedbackViewController animated:YES];
                // PROFILEタブを選択済にする
                //UINavigationController *profileTabViewController = self.tabBarController.viewControllers[4];
                //self.tabBarController.selectedViewController = profileTabViewController;
                //[profileTabViewController popToRootViewControllerAnimated:NO];
                // Restaurant追加へ遷移
                //[profileTabViewController.viewControllers[0] performSegueWithIdentifier:@"toFeedbackViewController" sender:nil];
                break;
            }
            case DropdownMenuViewSelectedItemTypeAppInfo:
            {
                // RESTAURANTタブを選択済にする
                //UINavigationController *restaurantTabViewController = self.tabBarController.viewControllers[2];
                //self.tabBarController.selectedViewController = restaurantTabViewController;
                //[restaurantTabViewController popToRootViewControllerAnimated:NO];
                // Restaurant追加へ遷移
                //[restaurantTabViewController.viewControllers[0] performSegueWithIdentifier:@"toAddRestaurantViewController" sender:nil];
                break;
            }
            default:
                break;
        }
        [self.delegate dropdownMenuViewDidSelectedItem:self type:type];
    }
    [self closeDropdownMenuView];
}

#pragma mark - Action methods

- (IBAction)tappedAddEventButton:(id)sender
{
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeAddEvent];
}

- (IBAction)tappedAddRestaurantButton:(id)sender {
    [self tappedButtonWithType:DropdownMenuViewSelectedItemTypeAddRestaurant];
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
