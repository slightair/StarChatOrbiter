//
//  SCOPreferencesRootView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPreferencesRootView.h"

#define kNavigationBarHeight 44

@interface SCOPreferencesRootView ()

@property (strong, nonatomic, readwrite) UINavigationBar *navigationBar;

@end

@implementation SCOPreferencesRootView

@synthesize navigationBar = _navigationBar;
@synthesize preferencesView = _preferencesView;

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
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    self.navigationBar.frame = CGRectMake(0, 0, viewSize.width, kNavigationBarHeight);
    self.preferencesView.frame = CGRectMake(0, kNavigationBarHeight, viewSize.width, viewSize.height - kNavigationBarHeight);
}

- (void)setPreferencesView:(UIView *)preferencesView
{
    [self.preferencesView removeFromSuperview];
    _preferencesView = preferencesView;
    
    [self addSubview:self.preferencesView];
    [self layoutSubviews];
}

@end
