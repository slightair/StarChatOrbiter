//
//  SCOUserCell.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/17.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOUserCell.h"

#define kCellPaddingHorizontal 12
#define kUserNameLabelHeight 24

@interface SCOUserCell ()

@property (strong, nonatomic) UILabel *userNameLabel;

@end

@implementation SCOUserCell

@synthesize userInfo = _userInfo;
@synthesize userNameLabel = _userNameLabel;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSCOUserCellIdentifier];
    if (self) {
        // Initialization code
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.userNameLabel.textColor = [UIColor darkGrayColor];
        self.userNameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.userNameLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentViewSize = self.contentView.bounds.size;
    
    self.userNameLabel.frame = CGRectMake(kCellPaddingHorizontal,
                                          floor((contentViewSize.height - kUserNameLabelHeight) / 2),
                                          floor(contentViewSize.width - kCellPaddingHorizontal * 2),
                                          kUserNameLabelHeight);
}

- (void)setUserInfo:(CLVStarChatUserInfo *)userInfo
{
    _userInfo = userInfo;
    
    self.userNameLabel.text = userInfo.nick;
}

@end
