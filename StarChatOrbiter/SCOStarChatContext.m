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
@property (strong, nonatomic, readwrite) NSArray *userKeywords;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) CLVStarChatAPIClient *apiClient;
@property (strong, nonatomic) NSMutableDictionary *channelUsers;
@property (strong, nonatomic) NSMutableDictionary *userNickDictionary;

@end

@implementation SCOStarChatContext

@synthesize baseURL = _baseURL;
@synthesize userInfo = _userInfo;
@synthesize subscribedChannels = _subscribedChannels;
@synthesize currentChannelInfo = _currentChannelInfo;
@synthesize userKeywords = _userKeywords;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize apiClient = _apiClient;
@synthesize channelUsers = _channelUsers;
@synthesize userNickDictionary = _userNickDictionary;

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
    self.channelUsers = [NSMutableDictionary dictionary];
    self.userNickDictionary = [NSMutableDictionary dictionary];
    self.userKeywords = [NSArray array];
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

- (NSArray *)usersForChannelName:(NSString *)channelName
{
    return [self.channelUsers objectForKey:channelName];
}

- (NSString *)nickForUserName:(NSString *)userName
{
    NSString *nick = [self.userNickDictionary objectForKey:userName];
    
    if (!nick) {
        NSError *error = nil;
        CLVStarChatUserInfo *user = [self.apiClient userInfoForName:userName error:&error];
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            [self postErrorNotification:error];
            
            return nil;
        }
        
        [self.userNickDictionary setObject:user.nick forKey:user.name];
        nick = user.nick;
    }
    
    return nick;
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
        
        for (CLVStarChatChannelInfo *channelInfo in channels) {
            NSError *error = nil;
            NSArray *users = [self.apiClient usersForChannel:channelInfo.name error:&error];
            
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
                [self postErrorNotification:error];

                return;
            }
            
            [self.channelUsers setObject:users forKey:channelInfo.name];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationUpdateChannelUsers
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObject:channelInfo.name forKey:@"channelName"]];
            
            for (CLVStarChatUserInfo *user in users) {
                if ([user.name isEqualToString:self.userName] && !self.userKeywords) {
                    self.userKeywords = user.keywords;
                }
                
                if (![self.userNickDictionary objectForKey:user.name]) {
                    [self.userNickDictionary setObject:user.nick forKey:user.name];
                }
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationUpdateNickDictionary
                                                      object:self];
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

- (void)setUserKeywords:(NSArray *)userKeywords
{
    _userKeywords = userKeywords;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSCOStarChatContextNotificationUpdateUserKeywords
                                                        object:self];
}

@end
