//
//  SCOPreferencesViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "QuickDialog.h"

#define kUserDefaultsStarChatURL @"UserDefaultsStarChatURL"
#define kUserDefaultsStarChatAccount @"UserDefaultsStarChatAccount"

@class SCOPreferencesViewController;

@protocol SCOPreferencesViewControllerLoginDelegate <NSObject>

- (void)preferencesViewControllerDidSuccessLoginProcess:(SCOPreferencesViewController *)controller;

@end

@interface SCOPreferencesViewController : QuickDialogController

@property (weak, nonatomic) id <SCOPreferencesViewControllerLoginDelegate> loginDelegate;

@end
