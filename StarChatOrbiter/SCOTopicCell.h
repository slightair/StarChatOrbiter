//
//  SCOTopicCell.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/17.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatTopicInfo.h"

NSString *const SCOTopicCellIdentifier;

@interface SCOTopicCell : UITableViewCell

+ (CGFloat)heightWithTopicInfo:(CLVStarChatTopicInfo *)topicInfo;

@property (strong, nonatomic) CLVStarChatTopicInfo *topicInfo;

@end
