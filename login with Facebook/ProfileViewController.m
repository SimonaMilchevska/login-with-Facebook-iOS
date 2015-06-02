//
//  ProfileViewController.m
//  login with Facebook
//
//  Created by Simona on 6/2/15.
//  Copyright (c) 2015 Simona. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize email,dateofbirth,username;

- (void)viewDidLoad
{
    [super viewDidLoad];
    email.delegate=self;
    dateofbirth.delegate=self;
    
    self.profilePicture.profileID = @"me";
    [self updateContent:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateContent:)
                                                 name:FBSDKProfileDidChangeNotification
                                               object:nil];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear");
    if (![[FBSDKAccessToken currentAccessToken] hasGranted:@"email"])
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"public_profile",@"email"]
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if ([result.grantedPermissions containsObject:@"email"]) {
                                        [self fetchData];
                                    } else {
                                        [self dismissViewControllerAnimated:YES completion:NULL];
                                    }
                                }];
    } else {
        [self fetchData];
    }
}

- (void)fetchData
{
    NSLog(@"fetch");
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=age_range,email,name,birthday" parameters:nil];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSLog(@"fetched user:%@", result);
                // result is a dictionary with the user's Facebook data
                NSDictionary *userData = (NSDictionary *)result;
                // Now add the data to the UI elements
                self.dateofbirth.text=userData[@"birthday"];
                self.email.text=userData[@"email"];
                self.username.text=userData[@"name"];
                
            }
        }];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateContent:(NSNotification *)notification
{
    if ([FBSDKAccessToken currentAccessToken]) {
        
    } else {
    }
}

#pragma Mark - dismiss keyboard

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [username resignFirstResponder];
    [email resignFirstResponder];
    [dateofbirth resignFirstResponder];
    
    return YES;
}

-(IBAction)onRadioBtn:(id)sender
{
    //_statusLabel.text = [NSString stringWithFormat:@"Selected: %@", sender.titleLabel.text];
    NSLog(@"sender %@",[sender titleForState:UIControlStateNormal]);
    
    
}

@end

