//
//  LoginViewController.m
//  DrupalMobileAppBoilerplateIOS
//
//  Created by Jeffrey Linwood on 3/7/12.
//  Copyright (c) 2012 Jeff Linwood. All rights reserved.
//

#import "LoginViewController.h"

#import "AppData.h"

#import <QuartzCore/QuartzCore.h>

@interface LoginViewController (Private)
- (BOOL) validateFormFields;
@end
@implementation LoginViewController

@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize loginButton = _loginButton;
@synthesize rememberMeSwitch = _rememberMeSwitch;

- (IBAction)login:(id)sender {
    //validate form fields to make sure they aren't blank
    if(![self validateFormFields]) {
        return;
    }
    [[AppData sharedInstance] loginToDrupalWithUsername:self.usernameTextField.text password:self.passwordTextField.text success:^(id response) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (BOOL) validateFormFields {
    BOOL validated = TRUE;
    if (self.usernameTextField.text == nil || self.usernameTextField.text.length == 0) {
        validated = FALSE;
        self.usernameTextField.layer.borderColor = [[UIColor redColor] CGColor];
        
    } else {
        self.usernameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    if (self.passwordTextField.text == nil || self.passwordTextField.text.length == 0) {
        validated = FALSE;
        self.passwordTextField.layer.borderColor = [[UIColor redColor] CGColor];
        
    } else {
        self.usernameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    return validated;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString* storedUsername = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString* storedPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    if (storedUsername != nil && storedPassword != nil) {
        self.usernameTextField.text = storedUsername;
        self.passwordTextField.text = storedPassword;
    }
    
    //give our input fields a little bit of design.
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.clipsToBounds      = YES;    
    self.usernameTextField.layer.borderWidth = 1.0f;
    
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.clipsToBounds      = YES;  
    self.passwordTextField.layer.borderWidth = 1.0f;
    
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
