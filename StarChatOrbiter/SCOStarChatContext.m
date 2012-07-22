//
//  SCOStarChatContext.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/18.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "GCDSingleton.h"
#import "SCOStarChatContext.h"

@interface SCOStarChatContext ()

- (void)resetContext;
- (void)updateInformation;
- (void)postErrorNotification:(NSError *)error;

@property (strong, nonatomic, readwrite) CLVStarChatUserInfo *userInfo;
@property (strong, nonatomic, readwrite) NSArray *subscribedChannels;
@property (strong, nonatomic, readwrite) CLVStarChatChannelInfo *currentChannelInfo;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) CLVStarChatAPIClient *apiClient;

@end

@implementation SCOStarChatContext

@synthesize baseURL = _baseURL;
@synthesize userInfo = _userInfo;
@synthesize subscribedChannels = _subscribedChannels;
@synthesize currentChannelInfo = _currentChannelInfo;
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
    self.userInfo = nil;
    self.subscribedChannels = [NSArray array];
}

- (void)loginUserName:(NSString *)userName
             password:(NSString *)password
           completion:(void (^)(void))completion
              failure:(void (^)(NSError *error))failure
{
    if (!self.apiClient) {
        NSError *error = [NSError errorWithDomain:kSCOStarChatContextErrorDomain code:SCOStarChatContextErrorAPIClientNotReady userInfo:nil];
        [self postErrorNotification:error];
        failure(error);
    }
    
    [self.apiClient setAuthorizationHeaderWithUsername:userName password:password];
    [self.apiClient sendPing:^{
        self.userName = userName;
        self.password = password;
        [self resetContext];
        
        [self.apiClient userInfoForName:self.userName
                             completion:^(CLVStarChatUserInfo *userInfo){
                                 self.userInfo = userInfo;
                                 [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationLoggedIn
                                                                                     object:self];
                                 [self updateInformation];
                                 completion();
                             }
                                failure:^(NSError *error){
                                    [self postErrorNotification:error];
                                    failure(error);
                                }];
    }
                     failure:^(NSError *error){
                         [self postErrorNotification:error];
                         failure(error);
                     }];
}

- (void)selectChannel:(NSString *)channelName
{
    NSUInteger index = [self.subscribedChannels indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
        return [[(CLVStarChatChannelInfo *)obj name] isEqualToString:channelName];
    }];
    
    if (index == NSNotFound) {
        return;
    }
    
    CLVStarChatChannelInfo *channelInfo = [self.subscribedChannels objectAtIndex:index];
    self.currentChannelInfo = channelInfo;
}

- (void)updateInformation
{
    if (!self.apiClient) {
        NSError *error = [NSError errorWithDomain:kSCOStarChatContextErrorDomain code:SCOStarChatContextErrorAPIClientNotReady userInfo:nil];
        [self postErrorNotification:error];
        return;
    }
    
    [self.apiClient subscribedChannels:^(NSArray *channels){
        self.subscribedChannels = channels;
        self.currentChannelInfo = [self.subscribedChannels objectAtIndex:0];
    }
                               failure:^(NSError *error){
                                   NSLog(@"%@", [error localizedDescription]);
                                   [self postErrorNotification:error];
                               }];
}

- (void)postErrorNotification:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationErrorOccured
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
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

- (void)setSubscribedChannels:(NSArray *)subscribedChannels
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _subscribedChannels = [subscribedChannels sortedArrayUsingDescriptors:sortDescriptors];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationUpdateSubscribedChannels
                                                        object:self];
}

- (void)setCurrentChannelInfo:(CLVStarChatChannelInfo *)currentChannelInfo
{
    _currentChannelInfo = currentChannelInfo;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationChangeCurrentChannelInfo
                                                        object:self];
}

@end
