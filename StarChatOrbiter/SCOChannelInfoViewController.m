//
//  SCOChannelInfoViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/09.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChannelInfoViewController.h"
#import "SCOChannelInfoView.h"
#import "SCOTopicCell.h"
#import "SCOUserCell.h"
#import "SCOStarChatContext.h"

#import "SBJson.h"

enum TableViewSections {
    kTopicSection = 0,
    kUsersSection,
    kNumberOfSections
};

@interface SCOChannelInfoViewController ()

- (void)didChangeCurrentChannelInfo:(NSNotification *)notification;
- (void)didUpdateChannelUsers:(NSNotification *)notification;
- (void)didRightSwipedChannelInfoView:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation SCOChannelInfoViewController

@synthesize users = _users;
@synthesize channelInfo = _channelInfo;
@synthesize sidebarDelegate = _sidebarDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeCurrentChannelInfo:)
                                                     name:kSCOStarChatContextNotificationChangeCurrentChannelInfo
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didUpdateChannelUsers:)
                                                     name:kSCOStarChatContextNotificationUpdateChannelUsers
                                                   object:nil];
    }
    return self;
}

- (void)loadView
{
    self.view = [[SCOChannelInfoView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    SCOChannelInfoView *channelInfoView = (SCOChannelInfoView *)self.view;
    
    channelInfoView.tableView.dataSource = self;
    channelInfoView.tableView.delegate = self;
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didRightSwipedChannelInfoView:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channelInfo = context.currentChannelInfo;
    self.users = [context usersForChannelName:self.channelInfo.name];
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

- (void)didChangeCurrentChannelInfo:(NSNotification *)notification
{
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channelInfo = context.currentChannelInfo;
}

- (void)didUpdateChannelUsers:(NSNotification *)notification
{
    if (![[notification.userInfo objectForKey:@"channelName"] isEqualToString:self.channelInfo.name]) {
        return;
    }
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.users = [context usersForChannelName:self.channelInfo.name];
}

- (void)didRightSwipedChannelInfoView:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.sidebarDelegate respondsToSelector:@selector(channelInfoViewController:didRightSwipedChannelInfoView:)]) {
        [self.sidebarDelegate channelInfoViewController:self didRightSwipedChannelInfoView:gestureRecognizer];
    }
}

- (void)setChannelInfo:(CLVStarChatChannelInfo *)channelInfo
{
    _channelInfo = channelInfo;
    
    SCOChannelInfoView *channelInfoView = (SCOChannelInfoView *)self.view;
    channelInfoView.headerView.headerTitleLabel.text = channelInfo.name;
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.users = [context usersForChannelName:self.channelInfo.name];
}

- (void)setUsers:(NSArray *)users
{
    _users = users;
    
    SCOChannelInfoView *channelInfoView = (SCOChannelInfoView *)self.view;
    
    [channelInfoView.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return kNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger rows = 0;
    
    switch (section) {
        case kTopicSection:
            rows = 1;
            break;
        
        case kUsersSection:
            rows = [self.users count];
            break;
        
        default:
            break;
    }
    
    return rows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case kTopicSection:
            cell = [tableView dequeueReusableCellWithIdentifier:kSCOTopicCellIdentifier];
            if (cell == nil) {
                cell = [[SCOTopicCell alloc] init];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            ((SCOTopicCell *)cell).topicInfo = self.channelInfo.topic;
            
            break;
        case kUsersSection:
            cell = [tableView dequeueReusableCellWithIdentifier:kSCOUserCellIdentifier];
            if (cell == nil) {
                cell = [[SCOUserCell alloc] init];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            ((SCOUserCell *)cell).userInfo = [self.users objectAtIndex:indexPath.row];
            
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    switch (section) {
        case kTopicSection:
            title = @"Topic";
            break;
        
        case kUsersSection:
            title = @"Users";
            break;
        
        default:
            break;
    }
    
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    switch (indexPath.section) {
        case kTopicSection:
            height = [SCOTopicCell heightWithTopicInfo:self.channelInfo.topic];
            break;
        
        case kUsersSection:
            height = 44;
            break;
        
        default:
            break;
    }
    
    return height;
}

@end
