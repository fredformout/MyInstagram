//
//  MiProfileViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfileViewController.h"
#import "UIImageView+DownloadImage.h"
#import "UIViewController+InitialState.h"

@interface MIProfileViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *fullnameLabel;

@end

@implementation MIProfileViewController
{
    BOOL viewDidAppearAtFirstTime;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewDidAppearAtFirstTime = NO;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.layer.cornerRadius = CGRectGetWidth(_photoImageView.frame) / 2;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!viewDidAppearAtFirstTime)
    {
        viewDidAppearAtFirstTime = YES;

        [_activityIndicatorView startAnimating];
        
        [_presenter getUser];
    }
}

#pragma mark - Actions

- (IBAction)logoutAction
{
    [_presenter logoutAction];
}

#pragma mark - MIProfileViewControllerInterface

- (void)showUser:(MIInstagramUser *)user
{
    [_activityIndicatorView stopAnimating];
    
    _usernameLabel.text = user.username;
    _fullnameLabel.text = user.fullname;
    [_photoImageView loadImageFromURL:[NSURL URLWithString:user.userPhotoURL]
                           cachingKey:user.identifier];
}

#pragma mark - UIViewController+InitialState

- (void)returnToInitialState
{
    viewDidAppearAtFirstTime = NO;
}

@end
