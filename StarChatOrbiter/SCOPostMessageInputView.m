//
//  SCOPostMessageInputView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPostMessageInputView.h"

#define kPostMessageTextFieldMarginLeft 36
#define kPostMessageTextFieldMarginRight 36
#define kPostMessageInputViewTopBorderWidth 1.0

@interface SCOPostMessageInputView ()

@property (strong, nonatomic, readwrite) UITextField *postMessageTextField;

@end

@implementation SCOPostMessageInputView

@synthesize postMessageTextField = _postMessageTextField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        
        self.postMessageTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.postMessageTextField.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.postMessageTextField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    self.postMessageTextField.frame = CGRectMake(kPostMessageTextFieldMarginLeft,
                                                 kPostMessageInputViewTopBorderWidth,
                                                 viewSize.width - (kPostMessageTextFieldMarginLeft + kPostMessageTextFieldMarginRight + kPostMessageInputViewTopBorderWidth),
                                                 viewSize.height);
}

@end
