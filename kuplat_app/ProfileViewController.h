//
//  ProfileViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownMenuView.h"

@interface ProfileViewController : UIViewController <DropdownMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImg;


//ドロップダウンメニュー
@property (strong, nonatomic) DropdownMenuView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

