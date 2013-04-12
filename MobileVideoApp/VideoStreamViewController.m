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
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation VideoStreamViewController

- (void) refresh:(NSNotification*)refresh {
    [self.tableView reloadData];
}

- (NSString*) thumbnailVideoURI:(NSString *)drupalURI {
    
    return [drupalURI stringByReplacingOccurrencesOfString:@"public://" withString:@"http://dirtrunning.com/sites/default/files/styles/large/public/"];
}

- (void) takeVideo:(id)sender {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.mediaTypes = @[(NSString*)kUTTypeMovie];

    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take Video", @"Choose Existing", nil];
        [actionSheet showInView:self.view];
    } else {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}
         
#pragma mark UIActionSheetDelegate methods
 - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
     if (buttonIndex == 0) {
         self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
     } else if (buttonIndex == 1) {
         self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     }
     
     [self presentViewController:self.imagePickerController animated:YES completion:nil];
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
    NSString *publicURI = [self thumbnailVideoURI:video.thumbnailDrupalURI];
    [videoCell.thumbnailImageView setImageWithURL:[NSURL URLWithString:publicURI]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

#pragma mark UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Image picked - %@",info);
	
}

#pragma mark UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Videos";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takeVideo:)];
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
