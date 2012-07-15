//
//  SCOChatLogViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChatLogViewController.h"
#import "SCOChatLogView.h"
#import "SCOChannelListViewController.h"
#import "SCOChannelInfoViewController.h"

#define kSideBarWidth 270

@interface SCOChatLogViewController ()

- (void)revealLeftSidebar:(id)sender;
- (void)revealRightSidebar:(id)sender;

@property (strong, nonatomic) UIViewController *leftSidebarViewController;
@property (strong, nonatomic) UIViewController *rightSidebarViewController;

@end

@implementation SCOChatLogViewController

@synthesize leftSidebarViewController = _leftSidebarViewController;
@synthesize rightSidebarViewController = _rightSidebarViewController;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"hoge";
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
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (void)revealRightSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateRight];
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

@end
