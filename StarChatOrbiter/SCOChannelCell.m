//
//  SCOChannelCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/16.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChannelCell.h"

#define kCellPaddingHorizontal 12
#define kChannelNameLabelHeight 24

@interface SCOChannelCell ()

@property (strong, nonatomic) UILabel *channelNameLabel;

@end

@implementation SCOChannelCell

@synthesize channelInfo = _channelInfo;
@synthesize channelNameLabel = _channelNameLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCOChannelCellIdentifier];
    if (self) {
        // Initialization code
        self.channelNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.channelNameLabel.textColor = [UIColor darkGrayColor];
        self.channelNameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.channelNameLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.bounds.size;
    
    self.channelNameLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                             floor((contentViewSize.height - kChannelNameLabelHeight) / 2),
                                             floor(contentViewSize.width - kCellPaddingHorizontal * 2),
                                             kChannelNameLabelHeight);
}

- (void)setChannelInfo:(CLVStarChatChannelInfo *)channelInfo
{
    _channelInfo = channelInfo;
    
    self.channelNameLabel.text = channelInfo.name;
}

@end
