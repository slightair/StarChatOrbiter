//
//  SCOSidebarHeaderView.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/14.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSidebarHeaderViewHeight 44

@interface SCOSidebarHeaderView : UIView

@property (strong, nonatomic, readonly) UILabel *headerTitleLabel;
@property (strong, nonatomic, readonly) UIButton *preferencesButton;

@end
