//
//  ANZDropDownField.h
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANZDropDownField : UITextField <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSArray* dropList;            // 表示するドロップリスト
@property (nonatomic) CGFloat displayNumOfRows;     // 表示件数
@property (nonatomic) CGFloat heightOfListItem;     // リストアイテムの高さ
@property (nonatomic) UIColor* borderColorForList;  // リストの枠線
@property (nonatomic) UIFont* fontOfListItem;       // リストアイテムのフォント

@end