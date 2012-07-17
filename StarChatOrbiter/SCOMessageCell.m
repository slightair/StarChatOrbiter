//
//  SCOMessageCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOMessageCell.h"
#import "TTTAttributedLabel.h"

#define kMessageFormat @"%@ %@: %@"
#define kCellPaddingHorizontal 12
#define kCellPaddingVertical 2

#define kMessageFontSize 12

#define kCellWidth 320
#define kMessageLabelHeightMax 1000

@interface SCOMessageCell ()

@property (strong, nonatomic) TTTAttributedLabel *messageLabel;

@end

@implementation SCOMessageCell

@synthesize messageInfo = _messageInfo;
@synthesize messageLabel = _messageLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSCOMessageCellIdentifier];
    if (self) {
        // Initialization code
        self.messageLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.messageLabel.textColor = [UIColor darkGrayColor];
        self.messageLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.font = [UIFont systemFontOfSize:kMessageFontSize];
        
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.bounds.size;
    
    self.messageLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                         kCellPaddingVertical,
                                         contentViewSize.width - kCellPaddingHorizontal * 2,
                                         contentViewSize.height - kCellPaddingVertical * 2);
}

- (void)setMessageInfo:(CLVStarChatMessageInfo *)messageInfo
{
    _messageInfo = messageInfo;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *nameString = messageInfo.userName;
    NSString *dateString = [dateFormatter stringFromDate:messageInfo.createdAt];
    
    [self.messageLabel setText:[NSString stringWithFormat:kMessageFormat, dateString, nameString, messageInfo.body] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
        
        NSRange dateRange = [[mutableAttributedString string] rangeOfString:dateString];
        NSRange nameRange = [[mutableAttributedString string] rangeOfString:nameString];
        UIColor *dateColor = [UIColor colorWithRed:0.54 green:0.59 blue:0.67 alpha:1.0];
        UIColor *nameColor = [UIColor colorWithRed:0.54 green:0.59 blue:0.67 alpha:1.0];
        UIFont *boldFont = [UIFont boldSystemFontOfSize:kMessageFontSize];
        CTFontRef boldFontRef = CTFontCreateWithName((__bridge CFStringRef)boldFont.fontName, boldFont.pointSize, NULL);
        
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[dateColor CGColor] range:dateRange];
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[nameColor CGColor] range:nameRange];
        if (boldFontRef) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)boldFontRef range:nameRange];
            CFRelease(boldFontRef);
        }
        
        return mutableAttributedString;
    }];
}

+ (CGFloat)heightWithMessageInfo:(CLVStarChatMessageInfo *)messageInfo
{
    NSString *nameString = messageInfo.userName;
    NSString *text = [NSString stringWithFormat:kMessageFormat, @"XX:XX:XX", nameString, messageInfo.body];
    
    CGFloat baseHeight = kCellPaddingVertical * 2;
    CGFloat messageHeight = [text sizeWithFont:[UIFont systemFontOfSize:kMessageFontSize]
                             constrainedToSize:CGSizeMake(kCellWidth - kCellPaddingHorizontal * 2, kMessageLabelHeightMax)
                                 lineBreakMode:UILineBreakModeCharacterWrap].height;
    CGFloat newLineBonus = ([[text componentsSeparatedByString:@"\n"] count] - 1) * kMessageFontSize;
    
    return baseHeight + messageHeight + newLineBonus;
}

@end
