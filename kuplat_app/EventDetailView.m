//
//  EventDetailView.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/24.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventDetailView.h"

@interface EventDetailView  ()

@property (weak, nonatomic) UIView *contentView;
@property (nonatomic) CGSize layoutSize;

@end

@implementation EventDetailView

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
    _contentView = [self st_loadAndAddContentViewFromNibNamed:@"EventDetailView"];
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
    // 幅の設定
    _layoutSize.width = width;
    // Labelのレイアウト幅は、_layoutSize.widthから左右のマージン分を引いたもの。
    _informationText.preferredMaxLayoutWidth = _layoutSize.width - 20*2;
    // systemLayoutSizeFittingSizeでConstraintのルールに従って高さを自動計算する。
    // selfではなく_contentViewであることに注意。
    _layoutSize.height = [_contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    // 小数点を四捨五入する
    _layoutSize.height = round(_layoutSize.height);
    // intrinsicContentSizeが変わったことをAuto Layoutに知らせる
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize
{
    // この中でsystemLayoutSizeFittingSizeを呼ばないこと。
    return _layoutSize;
}

@end
