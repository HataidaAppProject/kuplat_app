//
//  RestaurantDetailView.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/05.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "RestaurantDetailView.h"

@implementation RestaurantDetailView

// code上でobjectを作る時に呼ばれる
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self verticalScrollContentViewCommonInit];
    }
    return self;
}

// interface builder(storyboardやnibファイルなど)からobjectを作るときに呼ばれる
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self verticalScrollContentViewCommonInit];
    }
    return self;
}

- (void)verticalScrollContentViewCommonInit
{
    // xibからViewをロードし、Subviewとして貼り付ける。
    // ロードしたViewはcontentViewプロパティへ入れる。
    self.contentView = [self st_loadAndAddContentViewFromNibNamed:@"RestaurantDetailView"];
}

- (UIView *)st_loadAndAddContentViewFromNibNamed:(NSString *)nibNamed
{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:nibNamed owner:self options:nil] objectAtIndex:0];
    view.frame = self.bounds;
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (void)setLayoutWidth:(CGFloat)width
{
    CGFloat height;
    // Labelのレイアウト幅は、layoutSize.widthから左右のマージン分を引いたもの。
    self.informationText.preferredMaxLayoutWidth = width - 20*2;
    // systemLayoutSizeFittingSizeでConstraintのルールに従って高さを自動計算する。
    height = round([self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    // layoutSizeを指定
    self.layoutSize = CGSizeMake(width, height);
    // intrinsicContentSizeが変わったことをAuto Layoutに知らせる
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize
{
    // この中でsystemLayoutSizeFittingSizeを呼ばないこと。
    return self.layoutSize;
}


@end
