//
//  SCOChannelListView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChannelListView.h"

#define kAccountInfoViewHeight 44

@interface SCOChannelListView ()

@property (strong, nonatomic, readwrite) SCOAccountInfoView *accountInfoView;

@end

@implementation SCOChannelListView

@synthesize accountInfoView = _accountInfoView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        
        self.accountInfoView = [[SCOAccountInfoView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.accountInfoView];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize viewSize = self.bounds.size;
    
    self.accountInfoView.frame = CGRectMake(0, 0, viewSize.width, kAccountInfoViewHeight);
}

@end
