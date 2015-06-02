//
//  ViewController.h
//  login with Facebook
//
//  Created by Simona on 6/2/15.
//  Copyright (c) 2015 Simona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBSettings.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController<FBSDKLoginButtonDelegate>

@property (strong, nonatomic) FBSDKLoginButton *fbLoginView;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *continueButton;
- (IBAction)showLogin:(UIStoryboardSegue *)segue;


@end

