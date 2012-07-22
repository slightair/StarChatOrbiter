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

@end

@implementation SCOChannelInfoViewController

@synthesize users = _users;
@synthesize channelInfo = _channelInfo;

- (id)init
{
    self = [super init];
    if (self) {
        NSString *jsonString = @"[{\"name\":\"hoge\",\"nick\":\"hoge\"},{\"name\":\"foo\",\"nick\":\"foo\",\"keywords\":[\"nununu\"]}]";
        NSMutableArray *users = [NSMutableArray array];
        for (NSDictionary *userInfo in [jsonString JSONValue]) {
            [users addObject:[CLVStarChatUserInfo userInfoWithDictionary:userInfo]];
        }
        self.users = users;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeCurrentChannelInfo:)
                                                     name:kSCOStarChatContextNotificationChangeCurrentChannelInfo
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
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channelInfo = context.currentChannelInfo;
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

- (void)setChannelInfo:(CLVStarChatChannelInfo *)channelInfo
{
    _channelInfo = channelInfo;
    
    SCOChannelInfoView *channelInfoView = (SCOChannelInfoView *)self.view;
    channelInfoView.headerView.headerTitleLabel.text = channelInfo.name;
    
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
