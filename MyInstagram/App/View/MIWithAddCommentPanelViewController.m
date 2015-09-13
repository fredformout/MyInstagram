//
//  MIWithAddCommentPanelViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIWithAddCommentPanelViewController.h"

static NSTimeInterval kDurationOfAnimation = 0.0;

@interface MIWithAddCommentPanelViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation MIWithAddCommentPanelViewController

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Keyboard

- (void)closeKeyboard
{
    [_commentTextField resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (_commentTextField.isFirstResponder)
    {
        NSDictionary *info  = notification.userInfo;
        NSValue *value = info[UIKeyboardFrameEndUserInfoKey];
        
        CGRect rawFrame = [value CGRectValue];
        CGRect keyboardFrame = [self.view convertRect:rawFrame
                                             fromView:nil];
        
        [self setViewMovedUp:YES
                   withFrame:keyboardFrame];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSValue *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame
                                         fromView:nil];
    
    [self setViewMovedUp:NO
               withFrame:keyboardFrame];
}

- (void)setViewMovedUp:(BOOL)movedUp
             withFrame:(CGRect)keyboardRect
{
    [UIView animateWithDuration:kDurationOfAnimation
                     animations:^
    {
        CGFloat constant = movedUp ? keyboardRect.size.height - self.tabBarController.tabBar.bounds.size.height : 0.0;
        
        
        _bottomConstraint.constant = constant;
        
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Send

- (IBAction)sendCommentAction
{
    if (![_commentTextField.text isEqualToString:@""])
    {
        [self sendCommentWithText:_commentTextField.text];
        _commentTextField.text = @"";
        [_commentTextField resignFirstResponder];
    }
}

#pragma mark - Others

- (void)sendCommentWithText:(NSString *)text
{
    //
}

@end
