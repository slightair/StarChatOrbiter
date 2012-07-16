//
//  SCOMessageCell.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatMessageInfo.h"

#define kSCOMessageCellIdentifier @"SCOMessageCell"

@interface SCOMessageCell : UITableViewCell

@property (strong, nonatomic) CLVStarChatMessageInfo *messageInfo;

@end
