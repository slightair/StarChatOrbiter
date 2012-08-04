//
//  SCOChatLogView.m
//  StarChatOrbiter
//
//  Created by slightair on 12/07/08.
//  Copyright (c) 2012年 slightair. All rights reserved.
//

#import "SCOChatLogView.h"

@interface SCOChatLogView ()

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) SCOPostMessageInputView *postMessageInputView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) CGRect keyboardFrame;

@end

@implementation SCOChatLogView

@synthesize tableView = _tableView;
@synthesize postMessageInputView = _postMessageInputView;
@synthesize isEditing = _isEditing;
@synthesize keyboardFrame = _keyboardFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isEditing = NO;
        self.KeyboardFrame = CGRectZero;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.postMessageInputView = [[SCOPostMessageInputView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.tableView];
        [self addSubview:self.postMessageInputView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint keyboardOrigin = [self convertRect:self.keyboardFrame fromView:keyWindow].origin;
    CGFloat tableViewHeight = self.isEditing ? keyboardOrigin.y - kPostMessageInputViewHeight : viewSize.height - kPostMessageInputViewHeight;
    
    self.tableView.frame = CGRectMake(0, 0, viewSize.width, tableViewHeight);
    self.postMessageInputView.frame = CGRectMake(0, self.tableView.bounds.size.height, viewSize.width, kPostMessageInputViewHeight);
}

- (BOOL)isShowLastLine
{
    NSInteger rows = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:0];
    if (rows <= 0) {
        return YES;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rows - 1 inSection:0];
    UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return [[self.tableView visibleCells] containsObject:lastCell];
}

- (void)scrollsToBottom
{
    NSInteger rows = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:0];
    if (rows <= 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rows - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:UITableViewScrollPositionBottom
                                         animated:YES];
}

// Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;

    self.keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.isEditing = YES;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self layoutSubviews];
                         [self scrollsToBottom];
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    self.keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.isEditing = NO;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self layoutSubviews];
                         [self scrollsToBottom];
                     }];
}

@end
