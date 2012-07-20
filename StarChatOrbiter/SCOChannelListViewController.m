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

#import "SBJson.h"
#import "CLVStarChatChannelInfo.h"

@interface SCOChannelListViewController ()

- (void)didPushedPreferencesButton:(id)sender;

@end

@implementation SCOChannelListViewController

@synthesize channels = _channels;

- (id)init
{
    self = [super init];
    if (self) {
#warning debug
        NSString *jsonString = @"[{\"name\":\"はひふへほ\",\"privacy\":\"public\",\"user_num\":2},{\"name\":\"Lobby\",\"privacy\":\"public\",\"user_num\":3,\"topic\":{\"id\":6,\"created_at\":1339939789,\"user_name\":\"foo\",\"channel_name\":\"Lobby\",\"body\":\"nice topic\"}},{\"name\":\"test\",\"privacy\":\"private\",\"user_num\":2,\"topic\":{\"id\":4,\"created_at\":1339832042,\"user_name\":\"hoge\",\"channel_name\":\"test\",\"body\":\"topic topic\"}}]";
        NSMutableArray *channelInfoList = [NSMutableArray array];
        for (NSDictionary *channelInfo in [jsonString JSONValue]) {
            [channelInfoList addObject:[CLVStarChatChannelInfo channelInfoWithDictionary:channelInfo]];
        }
        self.channels = channelInfoList;
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
