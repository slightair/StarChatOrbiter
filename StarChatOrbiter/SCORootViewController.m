//
//  SCORootViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCORootViewController.h"
#import "SCOPreferencesRootViewController.h"

@interface SCORootViewController ()

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
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self presentModalViewController:[SCOPreferencesRootViewController sharedViewController] animated:YES];
    });
}

@end
