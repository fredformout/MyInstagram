//
//  MIAppDependencies.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIAppDependencies.h"

#import "MIAppDataStore.h"

#import "MIAppPresenter.h"
#import "MIAppRouter.h"

#import "MIPhotosPresenter.h"
#import "MIPhotosRouter.h"

#import "MIProfilePresenter.h"
#import "MIProfileRouter.h"

#import "MILoginPresenter.h"
#import "MILoginRouter.h"

static NSString *kPhotosViewControllerIdentifier = @"PhotosViewController";
static NSString *kProfileViewControllerIdentifier = @"ProfileViewController";

static NSString *kPopularTitle = @"Popular photos";
static NSString *kLikedByMeTitle = @"Photos liked by Me";
static NSString *kProfileTitle = @"Profile";

static NSString *kPopularTabBarItemTitle = @"Popular";
static NSString *kLikedByMeTabBarItemTitle = @"Liked by Me";
static NSString *kProfileTabBarItemTitle = @"Profile";

static NSString *kPopularTabBarItemImageName = @"popular_icon";
static NSString *kLikedByMeTabBarItemImageName = @"liked_icon";
static NSString *kProfileTabBarItemImageName = @"profile_icon";

@interface MIAppDependencies ()

@property (nonatomic, strong) MIAppPresenter *appPresenter;
@property (nonatomic, strong) MIAppRouter *appRouter;

@property (nonatomic, strong) MIPhotosPresenter *popularPhotosPresenter;
@property (nonatomic, strong) MIPhotosRouter *popularPhotosRouter;

@property (nonatomic, strong) MIPhotosPresenter *likedPhotosPresenter;
@property (nonatomic, strong) MIPhotosRouter *likedPhotosRouter;

@property (nonatomic, strong) MIProfilePresenter *profilePresenter;
@property (nonatomic, strong) MIProfileRouter *profileRouter;

@property (nonatomic, strong) MILoginPresenter *loginPresenter;
@property (nonatomic, strong) MILoginRouter *loginRouter;

@end

@implementation MIAppDependencies

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self configureDependencies];
    }
    
    return self;
}

#pragma mark - Others

- (void)configureDependencies
{
    [[MIAppDataStore sharedInstance] setup];
    
    //App
    _appRouter = [MIAppRouter new];
    _appPresenter = [MIAppPresenter new];
    
    //Popular
    MITabBarItemInfo *popularTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kPopularTabBarItemTitle
                                                                     imageName:kPopularTabBarItemImageName];
    _popularPhotosRouter = [[MIPhotosRouter alloc] initWithViewControllerIdentifier:kPhotosViewControllerIdentifier
                                                                              title:kPopularTitle
                                                                      tabBarItemInfo:popularTbiInfo];
    _popularPhotosPresenter = [MIPhotosPresenter new];
    
    //Liked by Me
    MITabBarItemInfo *likedTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kLikedByMeTabBarItemTitle
                                                                   imageName:kLikedByMeTabBarItemImageName];
    _likedPhotosRouter = [[MIPhotosRouter new] initWithViewControllerIdentifier:kPhotosViewControllerIdentifier
                                                                          title:kLikedByMeTitle
                                                                 tabBarItemInfo:likedTbiInfo];
    _likedPhotosPresenter = [MIPhotosPresenter new];
    
    //Profile
    MITabBarItemInfo *profileTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kProfileTabBarItemTitle
                                                                   imageName:kProfileTabBarItemImageName];
    _profileRouter = [[MIProfileRouter new] initWithViewControllerIdentifier:kProfileViewControllerIdentifier
                                                                       title:kProfileTitle
                                                              tabBarItemInfo:profileTbiInfo];
    _profilePresenter = [MIProfilePresenter new];
    
    //-------------------------//
    
    _appRouter.presenter = _appPresenter;
    _appRouter.innerRouters = @[_popularPhotosRouter, _likedPhotosRouter, _profileRouter];
    _appPresenter.router = _appRouter;
    
    _popularPhotosRouter.presenter = _popularPhotosPresenter;
    _popularPhotosPresenter.router = _popularPhotosRouter;
    
    _likedPhotosRouter.presenter = _likedPhotosPresenter;
    _likedPhotosPresenter.router = _likedPhotosRouter;
    
    _profileRouter.presenter = _profilePresenter;
    _profilePresenter.router = _profileRouter;
    
    _loginRouter = [MILoginRouter new];
    _loginPresenter = [MILoginPresenter new];
    _loginRouter.presenter = _loginPresenter;
    _loginPresenter.router = _loginRouter;
}

- (void)installAppViewControllerIntoWindow:(UIWindow *)window
{
    [_appRouter presentViewControllerFromWindow:window];
}

- (void)setupColorScheme
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:50.0/255.0
                                                                  green:106.0/255.0
                                                                   blue:161.0/255.0
                                                                  alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName : [UIFont fontWithName:@"MarkerFelt-Thin"
                                                                                                  size:20.0] }];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"MarkerFelt-Thin"
                                                                                                  size:20.0] }
                                                forState:UIControlStateNormal];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:37.0/255.0
                                                           green:41.0/255.0
                                                            blue:44.0/255.0
                                                           alpha:1.0]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"MarkerFelt-Thin"
                                                                                               size:12.0] }
                                             forState:UIControlStateNormal];
}

@end
