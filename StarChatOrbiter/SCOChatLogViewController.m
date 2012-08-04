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
#import "SCOMessageCell.h"
#import "SCOStarChatContext.h"

#import "SBJson.h"

#define kSideBarWidth 270
#define kMainViewHorizontalShadowOffset 3.0

@interface SCOChatLogViewController ()

- (void)revealLeftSidebar:(id)sender;
- (void)revealRightSidebar:(id)sender;
- (void)didChangeCurrentChannelInfo:(NSNotification *)notification;
- (void)didUpdateChannelMessages:(NSNotification *)notification;
- (void)didTappedLogView:(UIGestureRecognizer *)gestureRecognizer;

@property (strong, nonatomic) UIViewController *leftSidebarViewController;
@property (strong, nonatomic) UIViewController *rightSidebarViewController;

@end

@implementation SCOChatLogViewController

@synthesize leftSidebarViewController = _leftSidebarViewController;
@synthesize rightSidebarViewController = _rightSidebarViewController;
@synthesize channelInfo = _channelInfo;
@synthesize messages = _messages;

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeCurrentChannelInfo:)
                                                     name:kSCOStarChatContextNotificationChangeCurrentChannelInfo
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didUpdateChannelMessages:)
                                                     name:kSCOStarChatContextNotificationUpdateChannelMessages
                                                   object:nil];
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
    chatLogView.postMessageInputView.postMessageTextField.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedLogView:)];
    [chatLogView.tableView addGestureRecognizer:tapGestureRecognizer];
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channelInfo = context.currentChannelInfo;
    self.messages = [context messagesForChannelName:self.channelInfo.name];
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

- (void)didChangeCurrentChannelInfo:(NSNotification *)notification
{
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.channelInfo = context.currentChannelInfo;
}

- (void)didUpdateChannelMessages:(NSNotification *)notification
{
    if (![[notification.userInfo objectForKey:@"channelName"] isEqualToString:self.channelInfo.name]) {
        return;
    }
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.messages = [context messagesForChannelName:self.channelInfo.name];
}

- (void)didTappedLogView:(UIGestureRecognizer *)gestureRecognizer
{
    SCOChatLogView *chatLogView = (SCOChatLogView *)self.view;
    
    UITextField *textField = chatLogView.postMessageInputView.postMessageTextField;
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
}

- (void)setMessages:(NSArray *)messages
{
    SCOChatLogView *chatLogView = (SCOChatLogView *)self.view;
    BOOL isShowLastLine = [chatLogView isShowLastLine];
    
    _messages = messages;
    
    [chatLogView.tableView reloadData];
    if (isShowLastLine) {
        [chatLogView scrollsToBottom];
    }
}

- (void)setChannelInfo:(CLVStarChatChannelInfo *)channelInfo
{
    _channelInfo = channelInfo;
    
    self.title = channelInfo.name;
    
    SCOStarChatContext *context = [SCOStarChatContext sharedContext];
    
    self.messages = [context messagesForChannelName:self.channelInfo.name];
}

#pragma mark -
#pragma mark JTRevealSidebarDelegate

- (UIView *)viewForLeftSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    SCOChannelListViewController *viewController = (SCOChannelListViewController *)self.leftSidebarViewController;
    if (!viewController) {
        viewController = [[SCOChannelListViewController alloc] init];
        viewController.sidebarDelegate = self;
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

- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    }
    else {
        self.view.userInteractionEnabled = NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SCOMessageCell heightWithMessageInfo:[self.messages objectAtIndex:indexPath.row]];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -
#pragma mark SCOChannelListViewControllerSidebarDelegate

- (void)channelListViewController:(SCOChannelListViewController *)viewController didSelectChannelName:(NSString *)channelName
{
    [self.navigationController setRevealedState:JTRevealedStateNo];
}

@end
