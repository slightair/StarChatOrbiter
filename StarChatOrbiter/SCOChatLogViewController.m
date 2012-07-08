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

#define kSideBarWidth 270

@interface SCOChatLogViewController ()

- (void)revealLeftSidebar:(id)sender;

@property (strong, nonatomic) UIViewController *leftSidebarViewController;

@end

@implementation SCOChatLogViewController

@synthesize leftSidebarViewController = _leftSidebarViewController;

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

- (void)prepareApplication
{
    
}

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
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
    viewController.view.frame = CGRectMake(0, viewFrame.origin.y, kSideBarWidth, viewFrame.size.height);
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return viewController.view;
}

@end
