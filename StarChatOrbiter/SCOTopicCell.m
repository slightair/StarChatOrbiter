//
//  SCOTopicCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/17.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOTopicCell.h"

@implementation SCOTopicCell

@synthesize topicInfo = _topicInfo;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSCOTopicCellIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTopicInfo:(CLVStarChatTopicInfo *)topicInfo
{
    _topicInfo = topicInfo;
    
    self.textLabel.text = topicInfo.body;
}

@end
