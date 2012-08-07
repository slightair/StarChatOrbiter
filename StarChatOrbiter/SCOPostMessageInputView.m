//
//  SCOPostMessageInputView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPostMessageInputView.h"
#import <QuartzCore/QuartzCore.h>

#define kPostMessageTextFieldMarginLeft 6
#define kPostMessageTextFieldMarginRight 6
#define kPostMessageTextFieldHeight 24
#define kPostMessageInputViewTopBorderWidth 1
#define kMessageInputFontSize 14

@interface SCOPostMessageInputView ()

@property (strong, nonatomic) UIView *underlayView;
@property (strong, nonatomic, readwrite) UITextField *postMessageTextField;
@property (strong, nonatomic, readwrite) CAGradientLayer *gradientLayer;

@end

@implementation SCOPostMessageInputView

@synthesize underlayView = _underlayView;
@synthesize postMessageTextField = _postMessageTextField;
@synthesize gradientLayer = _gradientLayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        
        self.underlayView = [[UIView alloc] initWithFrame:CGRectZero];
        self.underlayView.backgroundColor = [UIColor grayColor];
        
        self.postMessageTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.postMessageTextField.backgroundColor = [UIColor whiteColor];
        self.postMessageTextField.font = [UIFont systemFontOfSize:kMessageInputFontSize];
        self.postMessageTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.postMessageTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.postMessageTextField.returnKeyType = UIReturnKeySend;
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = CGRectZero;
        self.gradientLayer.locations = [NSArray arrayWithObjects:
                                        [NSNumber numberWithFloat:0.0],
                                        [NSNumber numberWithFloat:0.2],
                                        [NSNumber numberWithFloat:0.8],
                                        [NSNumber numberWithFloat:1.0],
                                        nil];
        self.gradientLayer.colors = [NSArray arrayWithObjects:
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor,
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor,
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor,
                                     (id)[UIColor colorWithWhite:1.0 alpha:0.1].CGColor,
                                     nil];
        
        [self.underlayView.layer addSublayer:self.gradientLayer];
        [self.underlayView addSubview:self.postMessageTextField];
        [self addSubview:self.underlayView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    self.gradientLayer.frame = self.bounds;
    self.underlayView.frame = CGRectMake(0, kPostMessageInputViewTopBorderWidth, viewSize.width, viewSize.height - kPostMessageInputViewTopBorderWidth);
    self.postMessageTextField.frame = CGRectMake(kPostMessageTextFieldMarginLeft,
                                                 (viewSize.height - kPostMessageTextFieldHeight) / 2,
                                                 viewSize.width - (kPostMessageTextFieldMarginLeft + kPostMessageTextFieldMarginRight + kPostMessageInputViewTopBorderWidth),
                                                 kPostMessageTextFieldHeight);
}

@end
