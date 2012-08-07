//
//  SCOChannelInfoViewController.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatChannelInfo.h"

@interface SCOChannelInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) CLVStarChatChannelInfo *channelInfo;

@end
