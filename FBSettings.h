//
//  FBSettings.h
//  Voisant
//
//  Created by Simona on 5/24/15.
//  Copyright (c) 2015 Simona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBSettings : NSObject

+ (instancetype)defaultSettings;

@property (nonatomic, assign) BOOL shouldSkipLogin;
@end
