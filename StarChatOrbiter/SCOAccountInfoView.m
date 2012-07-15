//
//  SCOAccountInfoView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/14.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOAccountInfoView.h"
#import <QuartzCore/QuartzCore.h>

#define kAccountInfoViewPaddingVertical 8
#define kUserNameLabelMarginLeft 8
#define kPreferencesButtonMarginRight 8
#define kPreferencesButtonSize 28

@interface SCOAccountInfoView ()

@property (strong, nonatomic, readwrite) UILabel *userNameLabel;
@property (strong, nonatomic, readwrite) UIButton *preferencesButton;
@property (strong, nonatomic, readwrite) CAGradientLayer *gradientLayer;
@end

@implementation SCOAccountInfoView

@synthesize userNameLabel = _userNameLabel;
@synthesize preferencesButton = _preferencesButton;
@synthesize gradientLayer = _gradientLayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.userNameLabel.backgroundColor = [UIColor clearColor];
        self.userNameLabel.textColor = [UIColor whiteColor];
        self.userNameLabel.text = @"userName";
        
        self.preferencesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.preferencesButton setImage:[UIImage imageNamed:@"applicationIcon"] forState:UIControlStateNormal];
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = CGRectZero;
        self.gradientLayer.locations = [NSArray arrayWithObjects:
                                        [NSNumber numberWithFloat:0.0],
                                        [NSNumber numberWithFloat:0.05],
                                        [NSNumber numberWithFloat:0.95],
                                        [NSNumber numberWithFloat:1.0],
                                        nil];
        self.gradientLayer.colors = [NSArray arrayWithObjects:
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor,
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor,
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor,
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.1].CGColor,
                                     nil];
        
        [self.layer addSublayer:self.gradientLayer];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.preferencesButton];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize viewSize = self.bounds.size;
    
    self.gradientLayer.frame = self.bounds;
    self.userNameLabel.frame = CGRectMake(kUserNameLabelMarginLeft,
                                          kAccountInfoViewPaddingVertical,
                                          viewSize.width - (kUserNameLabelMarginLeft + kPreferencesButtonSize + kPreferencesButtonMarginRight),
                                          viewSize.height - kAccountInfoViewPaddingVertical * 2);
    self.preferencesButton.frame = CGRectMake(viewSize.width - (kPreferencesButtonSize + kPreferencesButtonMarginRight),
                                              kAccountInfoViewPaddingVertical,
                                              kPreferencesButtonSize,
                                              kPreferencesButtonSize);
}

@end
