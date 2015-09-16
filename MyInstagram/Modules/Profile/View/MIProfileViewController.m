//
//  MiProfileViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfileViewController.h"
#import "UIViewController+InitialState.h"
#import "MIInstagramConstants.h"
#import "MIFileUtility.h"
#import "MIImageCacheUtility.h"

@interface MIProfileViewController ()

@property (nonatomic, weak) MIInstagramUser *user;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *fullnameLabel;

@end

@implementation MIProfileViewController
{
    BOOL viewDidAppearAtFirstTime;
}

#pragma mark - NSObject

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    self.user = user;
    
    if (_user)
    {
        [self setupPhoto];
        
        _usernameLabel.text = user.username;
        _fullnameLabel.text = user.fullname;
    }
    else
    {
        [self returnToInitialState];
    }
}

#pragma mark - UIViewController+InitialState

- (void)returnToInitialState
{
    _photoImageView.image = nil;
    _usernameLabel.text = nil;
    _fullnameLabel.text = nil;
}

- (void)firstActions
{
    if (self.isViewLoaded
        && self.view.window)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
        {
            [_presenter getUser];
        });
    }
    else
    {
        viewDidAppearAtFirstTime = NO;
    }
}

#pragma mark - Others

- (void)setupPhoto
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupPhoto)
                                                 name:_user.userPhotoURL
                                               object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        __block UIImage *image = [[MIImageCacheUtility sharedInstance] imageForURLString:_user.userPhotoURL];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if (image)
            {
                [[NSNotificationCenter defaultCenter] removeObserver:self];
                
                [_activityIndicatorView stopAnimating];
                _photoImageView.image = image;
            }
            else
            {
                _photoImageView.image = nil;
                [_activityIndicatorView startAnimating];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                {
                    [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:_user.userPhotoURL
                                                                                          priority:DownloadContentOperationPriorityHigh];
                });
            }
        });
    });
}

@end
