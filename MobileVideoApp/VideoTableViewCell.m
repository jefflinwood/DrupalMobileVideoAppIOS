//
//  VideoTableViewCell.m
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/12/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

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

@end
