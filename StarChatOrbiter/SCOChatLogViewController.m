//
//  SCOChatLogViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SCOChatLogViewController.h"
#import "SCOChatLogView.h"
#import "SCOChannelListViewController.h"
#import "SCOChannelInfoViewController.h"
#import "SCOMessageCell.h"

#import "SBJson.h"

#define kSideBarWidth 270
#define kMainViewHorizontalShadowOffset 3.0

@interface SCOChatLogViewController ()

- (void)revealLeftSidebar:(id)sender;
- (void)revealRightSidebar:(id)sender;

@property (strong, nonatomic) UIViewController *leftSidebarViewController;
@property (strong, nonatomic) UIViewController *rightSidebarViewController;

@end

@implementation SCOChatLogViewController

@synthesize leftSidebarViewController = _leftSidebarViewController;
@synthesize rightSidebarViewController = _rightSidebarViewController;
@synthesize messages = _messages;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"hoge";
        
#warning debug
        NSString *jsonString = @"[{\"id\":461,\"user_name\":\"foo\",\"body\":\"あいうえお\",\"created_at\":1340372159,\"channel_name\":\"てすと\",\"notice\":false},{\"id\":462,\"user_name\":\"foo\",\"body\":\"かきくけこ\",\"created_at\":1340372162,\"channel_name\":\"てすと\",\"notice\":false},{\"id\":463,\"user_name\":\"foo\",\"body\":\"さしすせそ\",\"created_at\":1340372165,\"channel_name\":\"てすと\",\"notice\":false},{\"id\":464,\"user_name\":\"foo\",\"body\":\"ニャーン\",\"created_at\":1340372169,\"channel_name\":\"てすと\",\"notice\":false},{\"id\":465,\"user_name\":\"foo\",\"body\":\"ひろし\",\"created_at\":1340372199,\"channel_name\":\"てすと\",\"notice\":true}]";
        NSMutableArray *messageInfoList = [NSMutableArray array];
        for (NSDictionary *messageInfo in [jsonString JSONValue]) {
            [messageInfoList addObject:[CLVStarChatMessageInfo messageInfoWithDictionary:messageInfo]];
        }
        self.messages = messageInfoList;
    }
    return self;
}

- (void)loadView
{
    self.view = [[SCOChatLogView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"aaa" style:UIBarButtonItemStyleBordered target:self action:@selector(revealLeftSidebar:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"bbb" style:UIBarButtonItemStyleBordered target:self action:@selector(revealRightSidebar:)];
    
    self.navigationItem.revealSidebarDelegate = self;
    
    SCOChatLogView *chatLogView = (SCOChatLogView *)self.view;
    chatLogView.tableView.dataSource = self;
    chatLogView.tableView.delegate = self;
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

- (void)revealLeftSidebar:(id)sender {
    CALayer *layer = self.navigationController.view.layer;
    layer.shadowOpacity = 0.5;
    layer.shadowOffset = CGSizeMake(-kMainViewHorizontalShadowOffset, 0.0);
    layer.shadowPath = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (void)revealRightSidebar:(id)sender {
    CALayer *layer = self.navigationController.view.layer;
    layer.shadowOpacity = 0.5;
    layer.shadowOffset = CGSizeMake(kMainViewHorizontalShadowOffset, 0.0);
    layer.shadowPath = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    
    [self.navigationController toggleRevealState:JTRevealedStateRight];
}

- (void)setMessages:(NSArray *)messages
{
    _messages = messages;
    
    SCOChatLogView *chatLogView = (SCOChatLogView *)self.view;
    [chatLogView.tableView reloadData];
}

#pragma mark -
#pragma mark JTRevealSidebarDelegate

- (UIView *)viewForLeftSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    SCOChannelListViewController *viewController = (SCOChannelListViewController *)self.leftSidebarViewController;
    if (!viewController) {
        viewController = [[SCOChannelListViewController alloc] init];
        self.leftSidebarViewController = viewController;
    }
    viewController.view.frame = CGRectMake(0,
                                           viewFrame.origin.y,
                                           kSideBarWidth,
                                           viewFrame.size.height);
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return viewController.view;
}

- (UIView *)viewForRightSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    SCOChannelInfoViewController *viewController = (SCOChannelInfoViewController *)self.rightSidebarViewController;
    if (!viewController) {
        viewController = [[SCOChannelInfoViewController alloc] init];
        self.rightSidebarViewController = viewController;
    }
    viewController.view.frame = CGRectMake(self.navigationController.view.frame.size.width - kSideBarWidth,
                                           viewFrame.origin.y,
                                           kSideBarWidth,
                                           viewFrame.size.height);
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    return viewController.view;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.messages count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCOMessageCell *cell = (SCOMessageCell *)[tableView dequeueReusableCellWithIdentifier:kSCOMessageCellIdentifier];
    if (cell == nil) {
        cell = [[SCOMessageCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.messageInfo = [self.messages objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
