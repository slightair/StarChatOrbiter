//
//  SCOTopicCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/17.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOTopicCell.h"

#define kCellPaddingHorizontal 12
#define kCellPaddingVertical 8

#define kTopicFontSize 12

#define kCellWidth 270
#define kTopicLabelHeightMax 1000

@interface SCOTopicCell ()

@property (strong, nonatomic) UILabel *topicLabel;

@end

@implementation SCOTopicCell

@synthesize topicInfo = _topicInfo;
@synthesize topicLabel = _topicLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSCOTopicCellIdentifier];
    if (self) {
        // Initialization code
        self.topicLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.topicLabel.textColor = [UIColor darkGrayColor];
        self.topicLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        self.topicLabel.numberOfLines = 0;
        self.topicLabel.font = [UIFont systemFontOfSize:kTopicFontSize];
        
        [self.contentView addSubview:self.topicLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.bounds.size;
    
    self.topicLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                       kCellPaddingVertical,
                                       contentViewSize.width - kCellPaddingHorizontal * 2,
                                       contentViewSize.height - kCellPaddingVertical * 2);
}

- (void)setTopicInfo:(CLVStarChatTopicInfo *)topicInfo
{
    _topicInfo = topicInfo;
    
    self.topicLabel.text = topicInfo.body;
}

+ (CGFloat)heightWithTopicInfo:(CLVStarChatTopicInfo *)topicInfo
{
    CGFloat baseHeight = kCellPaddingVertical * 2;
    CGFloat topicHeight = [topicInfo.body sizeWithFont:[UIFont systemFontOfSize:kTopicFontSize]
                                     constrainedToSize:CGSizeMake(kCellWidth - kCellPaddingHorizontal * 2, kTopicLabelHeightMax)
                                         lineBreakMode:UILineBreakModeCharacterWrap].height;
    CGFloat newLineBonus = ([[topicInfo.body componentsSeparatedByString:@"\n"] count] - 1) * kTopicFontSize;
    
    return baseHeight + topicHeight + newLineBonus;
}

@end
