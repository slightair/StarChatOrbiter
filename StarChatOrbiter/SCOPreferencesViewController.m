//
//  SCOPreferencesViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "GCDSingleton.h"
#import "SCOPreferencesViewController.h"
#import "SCOPreferencesView.h"

@interface SCOPreferencesViewController ()
- (void)closeView:(id)sender;
@end

@implementation SCOPreferencesViewController

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
    self.view = [[SCOPreferencesView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    SCOPreferencesView *preferencesView = (SCOPreferencesView *)self.view;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(closeView:)];
    [preferencesView.navigationBar pushNavigationItem:self.navigationItem animated:NO];
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

@end
