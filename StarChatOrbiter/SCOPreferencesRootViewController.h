//
//  SCOPreferencesRootViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCOPreferencesViewController.h"

@interface SCOPreferencesRootViewController : UIViewController <SCOPreferencesViewControllerLoginDelegate>

+ (id)sharedViewController;

@end
