//
//  SCOChatLogViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "JTRevealSidebarV2Delegate.h"

@interface SCOChatLogViewController : UIViewController <JTRevealSidebarV2Delegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *messages;

@end
