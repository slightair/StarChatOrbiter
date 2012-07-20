//
//  SCOStarChatContext.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/18.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLVStarChatAPIClient.h"

NSString *const SCOStarChatContextErrorDomain;

NSString *const SCOStarChatContextNotificationErrorOccured;
NSString *const SCOStarChatContextNotificationLoggedIn;
NSString *const SCOStarChatContextNotificationUpdateSubscribedChannels;

enum SCOStarChatContextErrors {
    SCOStarChatContextErrorAPIClientNotReady = 1000,
};

@interface SCOStarChatContext : NSObject

+ (id)sharedContext;
- (void)loginUserName:(NSString *)userName
             password:(NSString *)password
           completion:(void (^)(void))completion
              failure:(void (^)(NSError *error))failure;

@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic, readonly) CLVStarChatUserInfo *userInfo;
@property (strong, nonatomic, readonly) NSArray *subscribedChannels;

@end
