//
//  VideoStreamViewController.h
//  MobileVideoApp
//
//  Created by Jeffrey Linwood on 4/10/13.
//  Copyright (c) 2013 Biscotti Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoStreamViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
