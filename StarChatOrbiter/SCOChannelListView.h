//
//  SCOChannelListView.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCOAccountInfoView.h"

@interface SCOChannelListView : UIView

@property (strong, nonatomic, readonly) SCOAccountInfoView *accountInfoView;
@property (strong, nonatomic, readonly) UITableView *tableView;

@end
