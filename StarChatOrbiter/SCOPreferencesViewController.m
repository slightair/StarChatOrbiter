//
//  SCOPreferencesViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPreferencesViewController.h"

@interface SCOPreferencesViewController ()

+ (QRootElement *)rootElement;

@end

@implementation SCOPreferencesViewController

+ (QRootElement *)rootElement
{
    QRootElement *root = [[QRootElement alloc] init];
    root.grouped = YES;
    
    [root addSection:[self serverSettingSection]];
    [root addSection:[self accountSettingSection]];
    [root addSection:[self loginButtonSection]];
    
    return root;
}

+ (QSection *)serverSettingSection
{
    QSection *serverSettingSection = [[QSection alloc] initWithTitle:@"Server"];
    
    QEntryElement *serverURLEntryElement = [[QEntryElement alloc] initWithTitle:@"URL"
                                                                          Value:nil
                                                                    Placeholder:@"Enter StarChat URL"];
    serverURLEntryElement.key = @"ServerURL";
    
    [serverSettingSection addElement:serverURLEntryElement];
    return serverSettingSection;
}

+ (QSection *)accountSettingSection
{
    QSection *accountSettingSection = [[QSection alloc] initWithTitle:@"Account"];
    
    QEntryElement *userNameEntryElement = [[QEntryElement alloc] initWithTitle:@"UserName"
                                                                         Value:nil
                                                                   Placeholder:@"Enter UserName"];
    userNameEntryElement.key = @"UserName";
    
    QEntryElement *passwordEntryElement = [[QEntryElement alloc] initWithTitle:@"Password"
                                                                         Value:nil
                                                                   Placeholder:@"Enter Password"];
    passwordEntryElement.key = @"Password";
    
    [accountSettingSection addElement:userNameEntryElement];
    [accountSettingSection addElement:passwordEntryElement];
    
    return accountSettingSection;
}

+ (QSection *)loginButtonSection
{
    QSection *loginButtonSection = [[QSection alloc] init];
    
    QButtonElement *loginButtonElement = [[QButtonElement alloc] initWithTitle:@"Log in"];
    loginButtonElement.onSelected = ^{
        NSLog(@"log in");
    };
    
    [loginButtonSection addElement:loginButtonElement];
    return loginButtonSection;
}

- (id)init
{
    self = [super initWithRoot:[SCOPreferencesViewController rootElement]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

@end
