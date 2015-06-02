//
//  ViewController.m
//  login with Facebook
//
//  Created by Simona on 6/2/15.
//  Copyright (c) 2015 Simona. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    BOOL _viewDidAppear;
    BOOL _viewIsVisible;
}

@synthesize fbLoginView;
#pragma mark - Object lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // We wire up the FBSDKLoginButton using the interface builder
        // but we could have also explicitly wired its delegate here.
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    self.loginButton.readPermissions = @[@"public_profile",@"email",@"user_birthday"];
    
    // If there's already a cached token, read the profile information.
    if ([FBSDKAccessToken currentAccessToken]) {
        [self observeProfileChange:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    FBSettings *settings = [FBSettings defaultSettings];
    if (_viewDidAppear) {
        _viewIsVisible = YES;
        // reset
        settings.shouldSkipLogin = NO;
    } else {
        if (settings.shouldSkipLogin || [FBSDKAccessToken currentAccessToken]) {
            [self performSegueWithIdentifier:@"showMain" sender:nil];
        } else {
            _viewIsVisible = YES;
        }
        _viewDidAppear = YES;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [FBSettings defaultSettings].shouldSkipLogin = YES;
    _viewIsVisible = NO;
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error) {
        NSLog(@"Unexpected login error: %@", error);
        NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
        NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else {
        if (_viewIsVisible) {
            [self performSegueWithIdentifier:@"showMain" sender:self];
        }
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    if (_viewIsVisible) {
        [self performSegueWithIdentifier:@"continue" sender:self];
    }
}

#pragma mark - Actions

- (IBAction)showLogin:(UIStoryboardSegue *)segue
{
    // This method exists in order to create an unwind segue to this controller.
}


#pragma mark - Observations

- (void)observeProfileChange:(NSNotification *)notfication {
    if ([FBSDKProfile currentProfile]) {
        // NSString *title = [NSString stringWithFormat:@"continue as %@", [FBSDKProfile currentProfile].name];
        //[self.continueButton setTitle:title forState:UIControlStateNormal];
    }
}

- (void)observeTokenChange:(NSNotification *)notfication {
    if (![FBSDKAccessToken currentAccessToken]) {
        //  [self.continueButton setTitle:@"continue as a guest" forState:UIControlStateNormal];
    } else {
        [self observeProfileChange:nil];
    }
}

@end
