//
//  SCOPreferencesViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPreferencesViewController.h"
#import "SCOStarChatContext.h"

@interface SCOPreferencesViewController ()

- (QRootElement *)rootElement;
- (QSection *)serverSettingSection;
- (QSection *)accountSettingSection;
- (QSection *)loginButtonSection;

@end

@implementation SCOPreferencesViewController

- (QRootElement *)rootElement
{
    QRootElement *root = [[QRootElement alloc] init];
    root.grouped = YES;
    
    [root addSection:[self serverSettingSection]];
    [root addSection:[self accountSettingSection]];
    [root addSection:[self loginButtonSection]];
    
    return root;
}

- (QSection *)serverSettingSection
{
    QSection *serverSettingSection = [[QSection alloc] initWithTitle:@"Server"];
    
    QEntryElement *serverURLEntryElement = [[QEntryElement alloc] initWithTitle:@"URL"
                                                                          Value:nil
                                                                    Placeholder:@"Enter StarChat URL"];
    serverURLEntryElement.key = @"ServerURL";
    serverURLEntryElement.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [serverSettingSection addElement:serverURLEntryElement];
    return serverSettingSection;
}

- (QSection *)accountSettingSection
{
    QSection *accountSettingSection = [[QSection alloc] initWithTitle:@"Account"];
    
    QEntryElement *userNameEntryElement = [[QEntryElement alloc] initWithTitle:@"UserName"
                                                                         Value:nil
                                                                   Placeholder:@"Enter UserName"];
    userNameEntryElement.key = @"UserName";
    userNameEntryElement.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    QEntryElement *passwordEntryElement = [[QEntryElement alloc] initWithTitle:@"Password"
                                                                         Value:nil
                                                                   Placeholder:@"Enter Password"];
    passwordEntryElement.key = @"Password";
    passwordEntryElement.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordEntryElement.secureTextEntry = YES;
    
    [accountSettingSection addElement:userNameEntryElement];
    [accountSettingSection addElement:passwordEntryElement];
    
    return accountSettingSection;
}

- (QSection *)loginButtonSection
{
    QSection *loginButtonSection = [[QSection alloc] init];
    
    QButtonElement *loginButtonElement = [[QButtonElement alloc] initWithTitle:@"Log in"];
    loginButtonElement.onSelected = ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        [self loading:YES];
        
        NSString *serverURLString = [(QEntryElement *)[self.root elementWithKey:@"ServerURL"] textValue];
        NSString *userName = [(QEntryElement *)[self.root elementWithKey:@"UserName"] textValue];
        NSString *password = [(QEntryElement *)[self.root elementWithKey:@"Password"] textValue];
        
        SCOStarChatContext *context = [SCOStarChatContext sharedContext];
        context.baseURL = [NSURL URLWithString:serverURLString];;
        [context loginUserName:userName
                      password:password
                    completion:^{
                        NSLog(@"success!!");
                    }
                       failure:^(NSError *error){
                           NSLog(@"%@", [error userInfo]);
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                               message:@"Login failed."
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                       }];
        
        [self loading:NO];
    };
    
    [loginButtonSection addElement:loginButtonElement];
    return loginButtonSection;
}

- (id)init
{
    self = [super initWithRoot:[self rootElement]];
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
