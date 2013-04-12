//
//  VideoStreamViewController.m
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/10/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import "VideoStreamViewController.h"

#import "AFNetworking.h"
#import "AppData.h"
#import "AppHelper.h"
#import "AppNotifications.h"
#import "Video.h"
#import "VideoTableViewCell.h"

@interface VideoStreamViewController ()

@end

@implementation VideoStreamViewController

- (void) refresh:(NSNotification*)refresh {
    [self.tableView reloadData];
}

- (NSString*) thumbnailVideoURI {
    return @"http://dirtrunning.com/sites/default/files/styles/large/public/videos/thumbnails/9/thumbnail-9_0003.jpg?itok=-iYZxO5e";
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[AppData sharedInstance] allVideos] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"VideoTableViewCell" owner:self options:nil][0];
    }
    Video *video = [[AppData sharedInstance] allVideos][indexPath.row];
    cell.titleLabel.text = video.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *videoCell = (VideoTableViewCell*)cell;
    Video *video = [[AppData sharedInstance] allVideos][indexPath.row];
    NSString *publicURI = [self thumbnailVideoURI];
    [videoCell.thumbnailImageView setImageWithURL:[NSURL URLWithString:publicURI]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

#pragma mark UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:VIDEOS_RELOADED object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
