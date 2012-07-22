//
//  SCOPreferencesRootViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "GCDSingleton.h"
#import "SCOPreferencesRootViewController.h"
#import "SCOPreferencesRootView.h"

@interface SCOPreferencesRootViewController ()

- (void)closeView:(id)sender;

@property (strong, nonatomic) SCOPreferencesViewController *preferencesViewController;

@end

@implementation SCOPreferencesRootViewController

@synthesize preferencesViewController = _preferencesViewController;

+ (id)sharedViewController
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Preferences";
    }
    return self;
}

- (void)loadView
{
    self.view = [[SCOPreferencesRootView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    SCOPreferencesRootView *preferencesRootView = (SCOPreferencesRootView *)self.view;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(closeView:)];
    [preferencesRootView.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    
    self.preferencesViewController = [[SCOPreferencesViewController alloc] init];
    self.preferencesViewController.loginDelegate = self;
    preferencesRootView.preferencesView = self.preferencesViewController.view;
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

- (void)closeView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)preferencesViewControllerDidSuccessLoginProcess:(SCOPreferencesViewController *)controller
{
    [self closeView:nil];
}

@end
