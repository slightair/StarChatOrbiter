//
//  SCOChannelListViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOAppDelegate.h"
#import "SCOChannelListViewController.h"
#import "SCOChannelListView.h"
#import "SCOPreferencesViewController.h"

#import "SCOChatLogViewController.h"

@interface SCOChannelListViewController ()

- (void)didPushedPreferencesButton:(id)sender;

@end

@implementation SCOChannelListViewController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)loadView
{
    self.view = [[SCOChannelListView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    SCOChannelListView *channelListView = (SCOChannelListView *)self.view;
    UIButton *preferencesButton = channelListView.accountInfoView.preferencesButton;
    [preferencesButton addTarget:self
                          action:@selector(didPushedPreferencesButton:)
                forControlEvents:UIControlEventTouchDown];
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

- (void)didPushedPreferencesButton:(id)sender
{
    
}

@end
