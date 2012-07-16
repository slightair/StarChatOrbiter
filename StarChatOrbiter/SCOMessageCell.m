//
//  SCOMessageCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOMessageCell.h"

#define kCellPaddingHorizontal 8
#define kNickLabelHeight 24

@interface SCOMessageCell ()

@property (strong, nonatomic) UILabel *nickLabel;
@property (strong, nonatomic) UILabel *messageBodyLabel;

@end

@implementation SCOMessageCell

@synthesize messageInfo = _messageInfo;
@synthesize nickLabel = _nickLabel;
@synthesize messageBodyLabel = _messageBodyLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSCOMessageCellIdentifier];
    if (self) {
        // Initialization code
        self.nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nickLabel.textColor = [UIColor darkGrayColor];
        self.nickLabel.backgroundColor = [UIColor cyanColor];
        
        self.messageBodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.messageBodyLabel.textColor = [UIColor darkGrayColor];
        self.messageBodyLabel.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.messageBodyLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.bounds.size;
    
    self.nickLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                      0,
                                      floor(contentViewSize.width - kCellPaddingHorizontal * 2),
                                      kNickLabelHeight);
    
    self.messageBodyLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                      kNickLabelHeight,
                                      floor(contentViewSize.width - kCellPaddingHorizontal * 2),
                                      kNickLabelHeight);
}

- (void)setMessageInfo:(CLVStarChatMessageInfo *)messageInfo
{
    _messageInfo = messageInfo;
    
    self.nickLabel.text = messageInfo.userName;
    self.messageBodyLabel.text = messageInfo.body;
}

@end
