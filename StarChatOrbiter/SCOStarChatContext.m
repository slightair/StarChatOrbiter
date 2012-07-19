//
//  SCOStarChatContext.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/18.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "GCDSingleton.h"
#import "SCOStarChatContext.h"
#import "CLVStarChatAPIClient.h"

@interface SCOStarChatContext ()

- (void)resetContext;

@property (strong, nonatomic, readwrite) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) CLVStarChatAPIClient *apiClient;

@end

@implementation SCOStarChatContext

@synthesize baseURL = _baseURL;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize apiClient = _apiClient;

+ (id)sharedContext
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (void)resetContext
{
    
}

- (void)loginUserName:(NSString *)userName
             password:(NSString *)password
           completion:(void (^)(void))completion
              failure:(void (^)(NSError *error))failure
{
    if (!self.apiClient) {
        NSError *error = [NSError errorWithDomain:kSCOStarChatContextErrorDomain code:SCOStarChatContextErrorAPIClientNotReady userInfo:nil];
        failure(error);
    }
    
    [self.apiClient setAuthorizationHeaderWithUsername:userName password:password];
    [self.apiClient sendPing:^{
        self.userName = userName;
        self.password = password;
        
        [self resetContext];
        
        completion();
    }
                     failure:^(NSError *error){
                         failure(error);
                     }];
}

- (void)setBaseURL:(NSURL *)baseURL
{
    if ([_baseURL isEqual:baseURL]) {
        return;
    }
    _baseURL = baseURL;
    
    self.apiClient = [[CLVStarChatAPIClient alloc] initWithBaseURL:self.baseURL];
    [self resetContext];
}

@end
