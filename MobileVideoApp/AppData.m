//
//  AppData.m
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/12/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import "AppData.h"

#import "AFNetworking.h"
#import "AppHelper.h"
#import "AppNotifications.h"
#import "Video.h"

@interface AppData()
@property (nonatomic, strong) NSArray *videos;
@end

@implementation AppData

static AppData *sharedData = nil;

- (NSArray*) allVideos {
    return self.videos;
}

#pragma mark Drupal Login methods
- (void) loginToDrupalWithUsername:(NSString*)username password:(NSString*)password success:(void(^)(id response))success failure:(void(^)(NSError *error))failure {
    //NSString *uri = [NSString stringWithFormat:@"%@%@",[self baseURI], @"/user/login"];
    NSURL *baseURL = [NSURL URLWithString:[self baseURI]];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    [httpClient postPath:@"/rest/user/login" parameters:@{@"username" : username, @"password" : password} success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"operation:%@",[operation responseString]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error logging in - %@",error);
    }];
}

#pragma mark Video Networking methods

- (NSString*) baseURI {
    return  @"http://dirtrunning.com/rest";
}

- (void) loadVideos {
    NSString *uri = [NSString stringWithFormat:@"%@%@",[self baseURI], @"/views/all_videos.json"];
    NSURL *url = [NSURL URLWithString:uri];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *results = JSON;
        NSMutableArray *videos = [[NSMutableArray alloc] init];
        for (NSDictionary *result in results) {
            Video *video = [[Video alloc] init];
            video.title = result[@"title"];
            NSNumber *created = result[@"created"];
            video.createdTimestamp = [created integerValue];
            NSDictionary *field_video = result[@"field_video"];
            if (field_video != nil && [field_video[@"und"] count] > 0) {
                NSDictionary *currentVideo = field_video[@"und"][0];
                NSDictionary *thumbnailfile = currentVideo[@"thumbnailfile"];
                video.thumbnailDrupalURI = thumbnailfile[@"uri"];
                
                NSArray *playablefiles = currentVideo[@"playablefiles"];
                for (NSDictionary *playablefile in playablefiles) {
                    if ([playablefile[@"filemime"] isEqualToString:@"video/mp4"]) {
                        video.mp4DrupalURI = playablefile[@"uri"];
                    }
                }
            }
            [videos addObject:video];
        }
        self.videos = [videos copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:VIDEOS_RELOADED object:nil];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        self.videos = nil;
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

#pragma mark Singleton method

//Anything we need to do to initialize the shared data singleton can go here.
+ (AppData*) sharedInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedData = [[AppData alloc] init];
        [sharedData loadVideos];
    });
    return sharedData;
}
@end
