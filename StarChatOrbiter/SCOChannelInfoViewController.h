//
//  SCOChannelInfoViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatChannelInfo.h"

@class SCOChannelInfoViewController;

@protocol SCOChannelInfoViewControllerSidebarDelegate <NSObject>

- (void)channelInfoViewController:(SCOChannelInfoViewController *)viewController didRightSwipedChannelInfoView:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface SCOChannelInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) CLVStarChatChannelInfo *channelInfo;
@property (assign, nonatomic) id <SCOChannelInfoViewControllerSidebarDelegate> sidebarDelegate;

@end
