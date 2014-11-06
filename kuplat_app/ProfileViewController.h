//
//  ProfileViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/15.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"

@interface ProfileViewController : UIViewController <MenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImg;


//ドロップダウンメニュー
@property (strong, nonatomic) MenuView *menuView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end

