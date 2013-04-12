//
//  LoginViewController.h
//  DrupalMobileAppBoilerplateIOS
//
//  Created by Jeffrey Linwood on 3/7/12.
//  Copyright (c) 2012 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

//UI Controls
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UISwitch *rememberMeSwitch;

//UI Actions
- (IBAction)login:(id)sender;


@end
