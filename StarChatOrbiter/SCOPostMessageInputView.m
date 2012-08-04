//
//  SCOPostMessageInputView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPostMessageInputView.h"

#define kPostMessageTextFieldMarginLeft 32
#define kPostMessageTextFieldMarginRight 32
#define kPostMessageTextFieldHeight 24
#define kPostMessageInputViewTopBorderWidth 1
#define kMessageInputFontSize 14

@interface SCOPostMessageInputView ()

@property (strong, nonatomic) UIView *underlayView;
@property (strong, nonatomic, readwrite) UITextField *postMessageTextField;

@end

@implementation SCOPostMessageInputView

@synthesize underlayView = _underlayView;
@synthesize postMessageTextField = _postMessageTextField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        
        self.underlayView = [[UIView alloc] initWithFrame:CGRectZero];
        self.underlayView.backgroundColor = [UIColor lightGrayColor];
        
        self.postMessageTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.postMessageTextField.backgroundColor = [UIColor whiteColor];
        self.postMessageTextField.font = [UIFont systemFontOfSize:kMessageInputFontSize];
        self.postMessageTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.underlayView addSubview:self.postMessageTextField];
        [self addSubview:self.underlayView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    self.underlayView.frame = CGRectMake(0, kPostMessageInputViewTopBorderWidth, viewSize.width, viewSize.height - kPostMessageInputViewTopBorderWidth);
    self.postMessageTextField.frame = CGRectMake(kPostMessageTextFieldMarginLeft,
                                                 (viewSize.height - kPostMessageTextFieldHeight) / 2,
                                                 viewSize.width - (kPostMessageTextFieldMarginLeft + kPostMessageTextFieldMarginRight + kPostMessageInputViewTopBorderWidth),
                                                 kPostMessageTextFieldHeight);
}

@end
