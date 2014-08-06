//
//  TextViewCell.m
//  testArrributedString
//
//  Created by 地引秀和 on 2014/08/06.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
