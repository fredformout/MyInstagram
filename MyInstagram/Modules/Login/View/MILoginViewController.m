//
//  MILoginViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILoginViewController.h"

#import "MIAPIBaseRequest.h"
#import "MIAPIDataManager.h"
#import "UICKeyChainStore+SharedInstance.h"
#import "MIInstagramConstants.h"

static NSTimeInterval kDurationOfAnimation = 0.5;

@interface MILoginViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UIButton *backButton;

@end

@implementation MILoginViewController

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _webView.alpha = 0.0;
}

#pragma mark - MILoginViewControllerInterface

- (void)openURL:(NSURLRequest *)urlRequest
{
    [UIView animateWithDuration:kDurationOfAnimation
                     animations:^
    {
        _webView.alpha = 1.0;
        _backButton.alpha = 1.0;
    }
                     completion:^(BOOL finished)
    {
        [_webView loadRequest:urlRequest];
    }];
}

#pragma mark - Actions

- (IBAction)loginAction
{
    [_presenter loginAction];
}

- (IBAction)backAction
{
    [UIView animateWithDuration:kDurationOfAnimation
                     animations:^
     {
         _webView.alpha = 0.0;
         _backButton.alpha = 0.0;
     }];
}

@end
