//
//  SCOChannelListViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCOChannelListViewController;

@protocol SCOChannelListViewControllerSidebarDelegate <NSObject>

- (void)channelListViewController:(SCOChannelListViewController *)viewController didSelectChannelName:(NSString *)channelName;

@end

@interface SCOChannelListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *channels;
@property (assign, nonatomic) id <SCOChannelListViewControllerSidebarDelegate> sidebarDelegate;

@end
