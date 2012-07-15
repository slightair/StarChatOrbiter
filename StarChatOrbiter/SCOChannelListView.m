//
//  SCOChannelListView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SCOChannelListView.h"

#define kAccountInfoViewHeight 44

@interface SCOChannelListView ()

@property (strong, nonatomic, readwrite) SCOAccountInfoView *accountInfoView;
@property (strong, nonatomic, readwrite) UITableView *tableView;

@end

@implementation SCOChannelListView

@synthesize accountInfoView = _accountInfoView;
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.accountInfoView = [[SCOAccountInfoView alloc] initWithFrame:CGRectZero];
        self.accountInfoView.layer.shadowOpacity = 0.5;
        self.accountInfoView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [self addSubview:self.tableView];
        [self addSubview:self.accountInfoView];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize viewSize = self.bounds.size;
    
    self.accountInfoView.frame = CGRectMake(0, 0, viewSize.width, kAccountInfoViewHeight);
    self.tableView.frame = CGRectMake(0, kAccountInfoViewHeight, viewSize.width, viewSize.height - kAccountInfoViewHeight);
}

@end
