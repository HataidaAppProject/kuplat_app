//
//  EventTableViewCell.m
//  kuplat_app
//
//  Created by 青野和巳 on 2014/10/30.
//  Copyright (c) 2014年 Wakabayashi.Lab. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell ()

@end

@implementation EventTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += self.insetH;
    frame.size.width -= 2 * self.insetH;
    frame.origin.y += self.insetV;
    frame.size.height -= 2 * self.insetV;
    [super setFrame:frame];
}

@end
