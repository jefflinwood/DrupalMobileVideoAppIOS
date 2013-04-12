//
//  VideoTableViewCell.h
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/12/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
