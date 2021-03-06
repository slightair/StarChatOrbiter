//
//  SCOMessageCell.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatMessageInfo.h"

#define kSCOMessageCellIdentifier @"SCOMessageCellIdentifier"

@interface SCOMessageCell : UITableViewCell

+ (CGFloat)heightWithMessageInfo:(CLVStarChatMessageInfo *)messageInfo;

@property (strong, nonatomic) CLVStarChatMessageInfo *messageInfo;

@end
