//
//  SCOMessageCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOMessageCell.h"
#import "TTTAttributedLabel.h"

#define kCellPaddingHorizontal 8
#define kCellPaddingVertical 2

#define kNameLabelHeight 16
#define kNameFontSize 12

#define kMessageBodyLabelMarginTop 2
#define kMessageBodyFontSize 12

@interface SCOMessageCell ()

@property (strong, nonatomic) TTTAttributedLabel *nameLabel;
@property (strong, nonatomic) TTTAttributedLabel *messageBodyLabel;

@end

@implementation SCOMessageCell

@synthesize messageInfo = _messageInfo;
@synthesize nameLabel = _nameLabel;
@synthesize messageBodyLabel = _messageBodyLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSCOMessageCellIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:kNameFontSize];
        
        self.messageBodyLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.messageBodyLabel.textColor = [UIColor darkGrayColor];
        self.messageBodyLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        self.messageBodyLabel.numberOfLines = 0;
        self.messageBodyLabel.font = [UIFont systemFontOfSize:kMessageBodyFontSize];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.messageBodyLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.bounds.size;
    
    self.nameLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                      kCellPaddingVertical,
                                      contentViewSize.width - kCellPaddingHorizontal * 2,
                                      kNameLabelHeight);
    
    self.messageBodyLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                      kCellPaddingVertical + kNameLabelHeight + kMessageBodyLabelMarginTop,
                                      contentViewSize.width - kCellPaddingHorizontal * 2,
                                      contentViewSize.height - (kCellPaddingVertical * 2 +
                                                                kNameLabelHeight +
                                                                kMessageBodyLabelMarginTop));
}

- (void)setMessageInfo:(CLVStarChatMessageInfo *)messageInfo
{
    _messageInfo = messageInfo;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *nameString = messageInfo.userName;
    NSString *dateString = [dateFormatter stringFromDate:messageInfo.createdAt];
    
    [self.nameLabel setText:[NSString stringWithFormat:@"%@ %@:", dateString, nameString] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
        
        NSRange dateRange = [[mutableAttributedString string] rangeOfString:dateString];
        NSRange nameRange = [[mutableAttributedString string] rangeOfString:nameString];
        UIColor *nameColor = [UIColor colorWithRed:0.4 green:0.6 blue:1.0 alpha:1.0];
        
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[[UIColor grayColor] CGColor] range:dateRange];
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[nameColor CGColor] range:nameRange];
        
        return mutableAttributedString;
    }];
    
    
    self.messageBodyLabel.text = messageInfo.body;
}

+ (CGFloat)heightWithMessageInfo:(CLVStarChatMessageInfo *)messageInfo
{
    CGFloat baseHeight = kCellPaddingVertical * 2 + kNameLabelHeight + kMessageBodyLabelMarginTop;
    CGFloat messageBodyHeight = [messageInfo.body sizeWithFont:[UIFont systemFontOfSize:kMessageBodyFontSize]
                                             constrainedToSize:CGSizeMake(320 - kCellPaddingHorizontal * 2, 1000)
                                                 lineBreakMode:UILineBreakModeCharacterWrap].height;
    CGFloat newLineBonus = ([[messageInfo.body componentsSeparatedByString:@"\n"] count] - 1) * kMessageBodyFontSize;
    
    return baseHeight + messageBodyHeight + newLineBonus;
}

@end
