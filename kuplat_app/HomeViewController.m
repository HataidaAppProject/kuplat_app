//
//  HomeViewController.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/09.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    //タブ色の設定 rgb=0,0,0
    [self.tabBarController.tabBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // メニュービュー
    self.menuView = [[[NSBundle mainBundle] loadNibNamed:@"MenuView"
                                                   owner:self
                                                 options:nil] lastObject];
    self.menuView.delegate = self;
    
    [self.menuView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *menuLayoutConstraints = [[NSMutableArray alloc] init];
    // 右端揃え
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.menuView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    // View内に収まるようにする（念のため）
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:self.overlayView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:self.overlayView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    // ボタンの1個の高さをNavigationBarの高さにする (縦横比はxibにて1:4)
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.menuView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:self.navigationController.navigationBar.frame.size.height*5]];
    // 底辺と画面の上端
    [menuLayoutConstraints addObject:[NSLayoutConstraint constraintWithItem:self.overlayView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.menuView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    
    [self.view addSubview:self.menuView];
    [self.view addConstraints:menuLayoutConstraints];
    
    
    /*****************
       ホーム画面上部
    *****************/
    
    
    /*****************
       ホーム画面下部
    *****************/
    //タップを有効化
    _imgTrendEvent.userInteractionEnabled = YES;
    _imgTrendRestaurant.userInteractionEnabled = YES;
    //タグを設定
    _imgTrendEvent.tag = 1;
    _imgTrendRestaurant.tag = 2;
    //アスペクト比を保ったままサイズ調整
    _imgTrendEvent.contentMode = UIViewContentModeScaleAspectFill;
    [_imgTrendEvent setClipsToBounds:YES];
    _imgTrendRestaurant.contentMode = UIViewContentModeScaleAspectFill;
    [_imgTrendRestaurant setClipsToBounds:YES];
    //画像を指定
    _imgTrendEvent.image = [UIImage imageNamed: @"SampleTrendEvent"];
    _imgTrendRestaurant.image = [UIImage imageNamed: @"SampleTrendRestaurant"];
    
    // 戻るボタンを変更
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"HOME"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    self.navigationItem.backBarButtonItem = btn;
}

/*****************
 画像をタップした際の遷移
 *****************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 1:
        {
            // イベント詳細へ遷移
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"EventDetailViewController" bundle:nil];
            EventDetailViewController *con = [sb instantiateInitialViewController];

            // EVENTタブのViewControllerを取得する
            UINavigationController *vc = self.tabBarController.viewControllers[1];
            // EVENTタブを選択済みにする
            self.tabBarController.selectedViewController = vc;
            // UINavigationControllerに追加済みのViewを一旦取り除く
            [vc popToRootViewControllerAnimated:NO];
            // EVENTViewの画面遷移処理を呼び出す
            [vc pushViewController:con animated:YES];
            
            break;
        }
        case 2:
            break;
        default:
            break;
    }
}


/*****************
      メニュー
 *****************/
- (IBAction)tappedMenuButton:(id)sender
{
    if (self.menuView.isMenuOpen) {
        [self hiddenOverlayView];
    } else {
        [self showOverlayView];
    }
    
    [self.menuView tappedMenuButton];
}

- (void)menuViewDidSelectedItem:(MenuView *)menuView type:(MenuViewSelectedItemType)type
{
    switch (type) {
        case MenuViewSelectedItemTypeAddRestaurant:

            break;
            
        case MenuViewSelectedItemTypeAddEvent:

            break;
            
        case MenuViewSelectedItemTypeModifyUserInfo:

            break;
            
        case MenuViewSelectedItemTypeCntact:

            break;
            
        case MenuViewSelectedItemTypeAppInfo:

            break;
            
        default:
            break;
    }
    [self hiddenOverlayView];
}

- (void)showOverlayView
{
    self.overlayView.hidden = NO;
    self.overlayView.alpha = 0.5;
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.overlayView.alpha = 0.5;
                     }
                     completion:^(BOOL finished){
                     }];
    
    [UIView commitAnimations];
}

- (void)hiddenOverlayView
{
    self.overlayView.alpha = 0.5;
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.overlayView.alpha = 0.5;
                     }
                     completion:^(BOOL finished){
                         self.overlayView.hidden = YES;
                     }];
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
