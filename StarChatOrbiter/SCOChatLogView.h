//
//  SCOChatLogView.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCOPostMessageInputView.h"

@interface SCOChatLogView : UIView

@property (strong, nonatomic, readonly) UITableView *tableView;
@property (strong, nonatomic, readonly) SCOPostMessageInputView *postMessageInputView;

@end
