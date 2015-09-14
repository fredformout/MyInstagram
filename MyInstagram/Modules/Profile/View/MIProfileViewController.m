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
#import "MIInstagramConstants.h"
#import "MIFileUtility.h"

@interface MIProfileViewController ()

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
    
    [_presenter initView];
    
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

        [self firstActions];
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
    [self setupPhoto];
    
    _usernameLabel.text = user.username;
    _fullnameLabel.text = user.fullname;
}

#pragma mark - UIViewController+InitialState

- (void)returnToInitialState
{
    //
}

- (void)firstActions
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [_presenter getUser];
    });
}

#pragma mark - Others

- (void)setupPhoto
{
    UIImage *image = [UIImage imageWithContentsOfFile:[MIFileUtility pathFromDocumentsForFilename:kUserPhotoPattern]];
    _photoImageView.image = image;
}

@end
