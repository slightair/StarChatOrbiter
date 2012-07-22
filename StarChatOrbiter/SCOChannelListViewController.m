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
- (void)didChangeCurrentChannelInfo:(NSNotification *)notification;
- (void)didPushedPreferencesButton:(id)sender;

@end

@implementation SCOChannelListViewController

@synthesize channels = _channels;
@synthesize sidebarDelegate = _sidebarDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didLogin:)
                                                     name:kSCOStarChatContextNotificationLoggedIn
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didUpdateSubscribedChannels:)
                                                     name:kSCOStarChatContextNotificationUpdateSubscribedChannels
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeCurrentChannelInfo:)
                                                     name:kSCOStarChatContextNotificationChangeCurrentChannelInfo
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
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channels = context.subscribedChannels;
    channelListView.headerView.headerTitleLabel.text = context.userInfo.nick;
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

- (void)didChangeCurrentChannelInfo:(NSNotification *)notification
{
    SCOChannelListView *channelListView = (SCOChannelListView *)self.view;
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    NSUInteger index = [self.channels indexOfObject:context.currentChannelInfo];
    if (index != NSNotFound) {
        [channelListView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                               animated:YES
                                         scrollPosition:UITableViewScrollPositionNone];
    }
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
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    NSUInteger index = [channels indexOfObject:context.currentChannelInfo];
    if (index != NSNotFound) {
        [channelListView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                               animated:YES
                                         scrollPosition:UITableViewScrollPositionNone];
    }
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
    SCOChannelCell *cell = (SCOChannelCell *)[tableView dequeueReusableCellWithIdentifier:kSCOChannelCellIdentifier];
    if (cell == nil) {
        cell = [[SCOChannelCell alloc] init];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.channelInfo = [self.channels objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    CLVStarChatChannelInfo *channelInfo = [self.channels objectAtIndex:indexPath.row];
    
    [context selectChannel:channelInfo.name];
    
    if ([self.sidebarDelegate respondsToSelector:@selector(channelListViewController:didSelectChannelName:)]) {
        [self.sidebarDelegate channelListViewController:self didSelectChannelName:channelInfo.name];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Channels";
}

@end
