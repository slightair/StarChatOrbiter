//
//  SCOChatLogView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChatLogView.h"

@interface SCOChatLogView ()

@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) SCOPostMessageInputView *postMessageInputView;

@end

@implementation SCOChatLogView

@synthesize tableView = _tableView;
@synthesize postMessageInputView = _postMessageInputView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.postMessageInputView = [[SCOPostMessageInputView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.tableView];
        [self addSubview:self.postMessageInputView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    self.tableView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height - kPostMessageInputViewHeight);
    self.postMessageInputView.frame = CGRectMake(0, self.tableView.bounds.size.height, viewSize.width, kPostMessageInputViewHeight);
}

@end
