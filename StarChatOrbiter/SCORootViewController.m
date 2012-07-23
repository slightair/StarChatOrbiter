//
//  SCORootViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCORootViewController.h"
#import "SCOPreferencesRootViewController.h"
#import "SSKeychain.h"
#import "SCOStarChatContext.h"

@interface SCORootViewController ()

- (void)loading:(BOOL)value;
- (void)showPreferencesView;

@property (strong, nonatomic, readwrite) UINavigationController *navigationController;
@property (strong, nonatomic, readwrite) SCOChatLogViewController *chatLogViewController;

@end

@implementation SCORootViewController

@synthesize navigationController = _navigationController;
@synthesize chatLogViewController = _chatLogViewController;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.chatLogViewController = [[SCOChatLogViewController alloc] init];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.chatLogViewController];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:self.navigationController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareApplication
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *savedStarChatURL = [userDefaults URLForKey:kUserDefaultsStarChatURL];
    
    if (savedStarChatURL) {
        NSString *account = [userDefaults objectForKey:kUserDefaultsStarChatAccount];
        NSString *password = [SSKeychain passwordForService:[savedStarChatURL absoluteString] account:account];
        
        SCOStarChatContext *context = [SCOStarChatContext sharedContext];
        context.baseURL = savedStarChatURL;
        
        [self loading:YES];
        [context loginUserName:account
                      password:password
                    completion:^{
                        [self loading:NO];
                    }
                       failure:^(NSError *error){
                           [self loading:NO];
                           [self showPreferencesView];
                       }];
    }
    else {
        [self showPreferencesView];
    }
}

- (void)showPreferencesView
{
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self presentModalViewController:[SCOPreferencesRootViewController sharedViewController] animated:YES];
    });
}


#pragma mark -
#pragma mark copied from QuickDialogController+Loading

- (UIView *)createLoadingView {
    UIView *loading = [[UIView alloc] init];
    loading.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    loading.autoresizingMask = UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleHeight;
    loading.tag = 1123002;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    [activity sizeToFit];
    activity.center = CGPointMake(loading.center.x, loading.frame.size.height/3);
    activity.autoresizingMask = UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleHeight;
    
    [loading addSubview:activity];
    
    [self.view addSubview:loading];
    [self.view bringSubviewToFront:loading];
    return loading;
}

- (void)loading:(BOOL)visible {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    UIView *loadingView = [self.view viewWithTag:1123002];
    if (loadingView==nil){
        loadingView = [self createLoadingView];
    }
    loadingView.frame = self.view.bounds;
    self.view.userInteractionEnabled = !visible;
    
    if (visible)
        loadingView.hidden = NO;
    
    loadingView.alpha = visible ? 0 : 1;
    [UIView animateWithDuration:0.3
                     animations:^{
                         loadingView.alpha = visible ? 1 : 0;
                     }
                     completion: ^(BOOL  finished) {
                         if (!visible) {
                             loadingView.hidden = YES;
                             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                         }
                     }];
}

@end
