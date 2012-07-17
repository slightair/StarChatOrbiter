//
//  SCOChannelCell.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatChannelInfo.h"

#define kSCOChannelCellIdentifier @"SCOChannelCell"

@interface SCOChannelCell : UITableViewCell

@property (strong, nonatomic) CLVStarChatChannelInfo *channelInfo;

@end
