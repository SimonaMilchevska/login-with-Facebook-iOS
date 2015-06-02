//
//  ProfileViewController.h
//  login with Facebook
//
//  Created by Simona on 6/2/15.
//  Copyright (c) 2015 Simona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class FBSDKProfilePictureView;

@interface ProfileViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UITextField *dateofbirth;
@property (strong, nonatomic) IBOutlet UITextField *email;


@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;
@property (nonatomic, strong) FBSDKGraphRequest *request;
@property (nonatomic, strong) NSString *requiredPermission;


-(IBAction)onRadioBtn:(id)sender;

@end
