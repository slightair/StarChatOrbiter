//
//  SCOChannelInfoView.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCOSidebarHeaderView.h"

@interface SCOChannelInfoView : UIView

@property (strong, nonatomic, readonly) SCOSidebarHeaderView *headerView;
@property (strong, nonatomic, readonly) UITableView *tableView;

@end
