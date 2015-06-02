//
//  FBSettings.m
//  Voisant
//
//  Created by Simona on 5/24/15.
//  Copyright (c) 2015 Simona. All rights reserved.
//

#import "FBSettings.h"

@implementation FBSettings

#pragma mark - Class Methods

+ (instancetype)defaultSettings
{
    static FBSettings *settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}

#pragma mark - Properties

static NSString *const kShouldSkipLoginKey = @"shouldSkipLogin";

- (BOOL)shouldSkipLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kShouldSkipLoginKey];
}

- (void)setShouldSkipLogin:(BOOL)shouldSkipLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:shouldSkipLogin forKey:kShouldSkipLoginKey];
    [defaults synchronize];
}

@end
