//
//  SCORootViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCOChatLogViewController.h"

@interface SCORootViewController : UIViewController

- (void)prepareApplication;

@property (strong, nonatomic, readonly) UINavigationController *navigationController;
@property (strong, nonatomic, readonly) SCOChatLogViewController *chatLogViewController;

@end
