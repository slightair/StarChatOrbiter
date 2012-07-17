//
//  SCOUserCell.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/17.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLVStarChatUserInfo.h"

#define kSCOUserCellIdentifier @"SCOUserCell"

@interface SCOUserCell : UITableViewCell

@property (strong, nonatomic) CLVStarChatUserInfo *userInfo;

@end
