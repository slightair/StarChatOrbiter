//
//  SCOAppDelegate.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/06.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOAppDelegate.h"

#ifdef TESTFLIGHT
#import "TestFlight.h"
#import "SCOTestFlightTeamToken.h"
#endif

@interface SCOAppDelegate ()

@property (strong, nonatomic, readwrite) SCORootViewController *rootViewController;

@end

@implementation SCOAppDelegate

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
#ifdef TESTFLIGHT
    [TestFlight takeOff:kTestFlightTeamToken];
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.rootViewController = [[SCORootViewController alloc] init];
    self.window.rootViewController = self.rootViewController;
    
    [self.window makeKeyAndVisible];
    [self.rootViewController performSelectorInBackground:@selector(prepareApplication) withObject:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
