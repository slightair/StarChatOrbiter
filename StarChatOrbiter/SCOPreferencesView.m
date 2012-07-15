//
//  SCOPreferencesView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPreferencesView.h"

#define kNavigationBarHeight 44

@interface SCOPreferencesView ()

@property (strong, nonatomic, readwrite) UINavigationBar *navigationBar;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SCOPreferencesView

@synthesize navigationBar = _navigationBar;
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        
        self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectZero];
        self.navigationBar.barStyle = UIBarStyleBlack;
        
        [self addSubview:self.navigationBar];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize viewSize = self.bounds.size;
    
    self.navigationBar.frame = CGRectMake(0, 0, viewSize.width, kNavigationBarHeight);
}

@end
