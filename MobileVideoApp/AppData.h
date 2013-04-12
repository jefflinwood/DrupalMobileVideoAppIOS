//
//  AppData.h
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/12/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Video;

@interface AppData : NSObject

- (void) loginToDrupalWithUsername:(NSString*)username password:(NSString*)password success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

- (NSArray*) allVideos;
- (void) loadVideos;

//data singleton
+ (AppData*) sharedInstance;
@end
