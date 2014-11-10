//
//  CustomView.m
//  CustomViewFromNib
//
//  Created by Morita Naoki on 2013/09/12.
//  Copyright (c) 2013年 molabo. All rights reserved.
//

#import "RestaurantMenuPriceTextFieldView.h"

@implementation RestaurantMenuPriceTextFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // make self from nib file
        UINib *nib = [UINib nibWithNibName:@"RestaurantMenuPriceTextFieldView" bundle:nil];
        self = [nib instantiateWithOwner:nil options:nil][0];
        
        // initialize here
    }
    
    [self.menu setKeyboardType:UIKeyboardTypeDefault];
    [self.price setKeyboardType:UIKeyboardTypeNumberPad];
    
    return self;
}

@end
