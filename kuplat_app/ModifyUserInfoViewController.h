//
//  ModifyUserInfoViewController.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSelectField;
@property (weak, nonatomic) IBOutlet UITextField *studentIDField;
@property (weak, nonatomic) IBOutlet UITextField *clubField1;
@property (weak, nonatomic) IBOutlet UITextField *clubField2;
@property (weak, nonatomic) IBOutlet UITextField *clubField3;

- (IBAction)pushModifyUserInfoBotton:(id)sender;
@end
