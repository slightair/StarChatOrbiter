//
//  SCOChannelListView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChannelListView.h"

@interface SCOChannelListView ()

@property (strong, nonatomic, readwrite) SCOSidebarHeaderView *headerView;
@property (strong, nonatomic, readwrite) UITableView *tableView;

@end

@implementation SCOChannelListView

@synthesize headerView = _headerView;
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.headerView = [[SCOSidebarHeaderView alloc] initWithFrame:CGRectZero];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [self addSubview:self.tableView];
        [self addSubview:self.headerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    self.headerView.frame = CGRectMake(0, 0, viewSize.width, kSidebarHeaderViewHeight);
    self.tableView.frame = CGRectMake(0, kSidebarHeaderViewHeight, viewSize.width, viewSize.height - kSidebarHeaderViewHeight);
}

@end
