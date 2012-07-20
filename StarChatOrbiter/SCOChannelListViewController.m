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
#import "SCOPreferencesRootViewController.h"
#import "SCOChannelCell.h"
#import "SCOStarChatContext.h"

@interface SCOChannelListViewController ()

- (void)didLogin:(NSNotification *)notification;
- (void)didUpdateSubscribedChannels:(NSNotification *)notification;
- (void)didPushedPreferencesButton:(id)sender;

@end

@implementation SCOChannelListViewController

@synthesize channels = _channels;

- (id)init
{
    self = [super init];
    if (self) {
        self.channels = [NSArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didLogin:)
                                                     name:SCOStarChatContextNotificationLoggedIn
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didUpdateSubscribedChannels:)
                                                     name:SCOStarChatContextNotificationUpdateSubscribedChannels
                                                   object:nil];
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
    
    UIButton *preferencesButton = channelListView.headerView.preferencesButton;
    [preferencesButton addTarget:self
                          action:@selector(didPushedPreferencesButton:)
                forControlEvents:UIControlEventTouchUpInside];
    
    channelListView.tableView.dataSource = self;
    channelListView.tableView.delegate = self;
    
    channelListView.headerView.headerTitleLabel.text = @"userName";
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

- (void)didLogin:(NSNotification *)notification
{
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    SCOChannelListView *channelListView = (SCOChannelListView *)self.view;
    
    channelListView.headerView.headerTitleLabel.text = context.userInfo.nick;
}

- (void)didUpdateSubscribedChannels:(NSNotification *)notification
{
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channels = context.subscribedChannels;
}

- (void)didPushedPreferencesButton:(id)sender
{
    UIViewController *rootViewController = [(SCOAppDelegate *)[UIApplication sharedApplication].delegate rootViewController];
    
    UIViewController *preferencesRootViewController = (UIViewController *)[SCOPreferencesRootViewController sharedViewController];
    preferencesRootViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    preferencesRootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [rootViewController presentViewController:preferencesRootViewController
                                     animated:YES
                                   completion:^{
                                   }];
}

- (void)setChannels:(NSArray *)channels
{
    _channels = channels;
    
    SCOChannelListView *channelListView = (SCOChannelListView *)self.view;
    [channelListView.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.channels count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCOChannelCell *cell = (SCOChannelCell *)[tableView dequeueReusableCellWithIdentifier:SCOChannelCellIdentifier];
    if (cell == nil) {
        cell = [[SCOChannelCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.channelInfo = [self.channels objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Channels";
}

@end
