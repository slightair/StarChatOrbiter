//
//  SCOAppDelegate.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/06.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCORootViewController.h"

@interface SCOAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) SCORootViewController *rootViewController;

@end
