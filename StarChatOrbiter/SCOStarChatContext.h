//
//  SCOStarChatContext.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/18.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLVStarChatAPIClient.h"

#define kSCOStarChatContextErrorDomain @"SCOStarChatContextErrorDomain"

#define kSCOStarChatContextNotificationErrorOccured @"SCOStarChatContextNotificationErrorOccured"
#define kSCOStarChatContextNotificationLoggedIn @"SCOStarChatContextNotificationLoggedIn"
#define kSCOStarChatContextNotificationUpdateSubscribedChannels @"SCOStarChatContextNotificationUpdateSubscribedChannels"
#define kSCOStarChatContextNotificationChangeCurrentChannelInfo @"SCOStarChatContextNotificationChangeCurrentChannelInfo"
#define kSCOStarChatContextNotificationUpdateChannelUsers @"SCOStarChatContextNotificationUpdateChannelUsers"
#define kSCOStarChatContextNotificationUpdateChannelMessages @"SCOStarChatContextNotificationUpdateChannelMessages"
#define kSCOStarChatContextNotificationUpdateNickDictionary @"SCOStarChatContextNotificationUpdateNickDictionary"
#define kSCOStarChatContextNotificationUpdateUserKeywords @"SCOStarChatContextNotificationUpdateUserKeywords"

enum SCOStarChatContextErrors {
    SCOStarChatContextErrorAPIClientNotReady = 1000,
};

@interface SCOStarChatContext : NSObject <CLVStarChatAPIClientDelegate>

+ (id)sharedContext;
- (void)loginUserName:(NSString *)userName
             password:(NSString *)password
           completion:(void (^)(void))completion
              failure:(void (^)(NSError *error))failure;
- (void)selectChannel:(NSString *)channelName;
- (NSArray *)usersForChannelName:(NSString *)channelName;
- (NSArray *)messagesForChannelName:(NSString *)channelName;
- (NSString *)nickForUserName:(NSString *)userName;

@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic, readonly) CLVStarChatUserInfo *userInfo;
@property (strong, nonatomic, readonly) NSArray *subscribedChannels;
@property (strong, nonatomic, readonly) CLVStarChatChannelInfo *currentChannelInfo;
@property (strong, nonatomic, readonly) NSArray *userKeywords;

@end
