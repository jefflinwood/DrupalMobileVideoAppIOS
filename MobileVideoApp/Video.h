//
//  Video.h
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/12/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnailDrupalURI;
@property (nonatomic, assign) NSTimeInterval createdTimestamp;
@property (nonatomic, strong) NSString *mp4DrupalURI;
@end
