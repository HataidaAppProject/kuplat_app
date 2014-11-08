//
//  UIScrollView+TouchEvent.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/11/08.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "UIScrollView+TouchEvent.h"

@implementation UIScrollView(TouchEvent)

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end