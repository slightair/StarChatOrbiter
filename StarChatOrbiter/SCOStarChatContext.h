//
//  SCOStarChatContext.h
//  StarChatOrbiter
//
//  Created by slightair on 12/07/18.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSCOStarChatContextErrorDomain @"SCOStarChatContextErrorDomain"

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
@property (strong, nonatomic, readonly) NSString *userName;

@end
