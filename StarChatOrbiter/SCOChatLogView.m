//
//  SCOChatLogView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChatLogView.h"

#define kNavigationBarHeight 44

@implementation SCOChatLogView

@synthesize navigationBar = _navigationBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectZero];
        self.navigationBar.barStyle = UIBarStyleBlack;
        
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"aaa"];
        [self.navigationBar setItems:[NSArray arrayWithObject:navigationItem]];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.navigationBar];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.navigationBar.frame = CGRectMake(0, statusBarHeight, screenWidth, kNavigationBarHeight);
}

- (void)setTitle:(NSString *)title
{
    [[self.navigationBar topItem] setTitle:title];
}

@end
