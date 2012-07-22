//
//  SCOPreferencesViewController.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/15.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOPreferencesViewController.h"
#import "SCOStarChatContext.h"
#import "SSKeychain.h"

@interface SCOPreferencesViewController ()

- (QRootElement *)rootElement;
- (QSection *)serverSettingSection;
- (QSection *)accountSettingSection;
- (QSection *)loginButtonSection;
- (void)clearAllPasswords;

@end

@implementation SCOPreferencesViewController

@synthesize loginDelegate = _loginDelegate;

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
    NSString *service = [[[NSUserDefaults standardUserDefaults] URLForKey:kUserDefaultsStarChatURL] absoluteString];
    
    QSection *serverSettingSection = [[QSection alloc] initWithTitle:@"Server"];
    
    QEntryElement *serverURLEntryElement = [[QEntryElement alloc] initWithTitle:@"URL"
                                                                          Value:nil
                                                                    Placeholder:@"Enter StarChat URL"];
    serverURLEntryElement.key = @"ServerURL";
    serverURLEntryElement.autocapitalizationType = UITextAutocapitalizationTypeNone;
    serverURLEntryElement.textValue = service;
    
    [serverSettingSection addElement:serverURLEntryElement];
    return serverSettingSection;
}

- (QSection *)accountSettingSection
{
    NSString *service = [[[NSUserDefaults standardUserDefaults] URLForKey:kUserDefaultsStarChatURL] absoluteString];
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsStarChatAccount];
    NSString *password = [SSKeychain passwordForService:service account:account];
    
    QSection *accountSettingSection = [[QSection alloc] initWithTitle:@"Account"];
    
    QEntryElement *userNameEntryElement = [[QEntryElement alloc] initWithTitle:@"UserName"
                                                                         Value:nil
                                                                   Placeholder:@"Enter UserName"];
    userNameEntryElement.key = @"UserName";
    userNameEntryElement.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userNameEntryElement.textValue = account;
    
    QEntryElement *passwordEntryElement = [[QEntryElement alloc] initWithTitle:@"Password"
                                                                         Value:nil
                                                                   Placeholder:@"Enter Password"];
    passwordEntryElement.key = @"Password";
    passwordEntryElement.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordEntryElement.secureTextEntry = YES;
    passwordEntryElement.textValue = password;
    
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
        NSURL *baseURL = [NSURL URLWithString:serverURLString];
        context.baseURL = baseURL;
        [context loginUserName:userName
                      password:password
                    completion:^{
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setURL:baseURL forKey:kUserDefaultsStarChatURL];
                        [userDefaults setObject:userName forKey:kUserDefaultsStarChatAccount];
                        [userDefaults synchronize];
                        
                        [self clearAllPasswords];
                        if (![SSKeychain setPassword:password forService:[baseURL absoluteString] account:userName]) {
                            NSLog(@"Cannot save password!");
                        }
                        
                        if ([self.loginDelegate respondsToSelector:@selector(preferencesViewControllerDidSuccessLoginProcess:)]) {
                            [self.loginDelegate preferencesViewControllerDidSuccessLoginProcess:self];
                        }
                    }
                       failure:^(NSError *error){
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                               message:[NSString stringWithFormat:@"Login failed.\n(%@)", [error localizedDescription]]
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

- (void)clearAllPasswords
{
    for (NSDictionary *key in [SSKeychain allAccounts]) {
        NSString *service = [key objectForKey:@"svce"];
        NSString *account = [key objectForKey:@"acct"];
        
        [SSKeychain deletePasswordForService:service account:account];
    }
}

@end
