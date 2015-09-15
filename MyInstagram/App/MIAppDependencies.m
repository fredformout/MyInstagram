//
//  MIAppDependencies.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIAppDependencies.h"

#import "MIAppRouter.h"
#import "MIAppPresenter.h"

#import "MIPhotosRouter.h"
#import "MIPhotosPresenter.h"
#import "MIPopularPhotosInteractor.h"
#import "MILikedByMeInteractor.h"

#import "MIProfileRouter.h"
#import "MIProfilePresenter.h"
#import "MIProfileInteractor.h"

#import "MIPhotoDetailsRouter.h"
#import "MIPhotoDetailsPresenter.h"
#import "MIPhotoDetailsInteractor.h"

#import "MICommentsRouter.h"
#import "MICommentsPresenter.h"
#import "MICommentsInteractor.h"

#import "MILoginRouter.h"
#import "MILoginPresenter.h"
#import "MILoginInteractor.h"

static NSString *kPhotosViewControllerIdentifier = @"PhotosCollectionViewController";
static NSString *kProfileViewControllerIdentifier = @"ProfileViewController";

static NSString *kCommentsViewControllerIdentifier = @"CommentsViewController";

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
@property (nonatomic, strong) MILoginPresenter *loginPresenter;

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
    //App
    MIAppRouter *appRouter = [MIAppRouter new];
    _appPresenter = [MIAppPresenter new];
    
    //Popular
    MITabBarItemInfo *popularTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kPopularTabBarItemTitle
                                                                     imageName:kPopularTabBarItemImageName];
    MIPhotosRouter *popularPhotosRouter = [[MIPhotosRouter alloc] initWithViewControllerIdentifier:kPhotosViewControllerIdentifier
                                                                              title:kPopularTitle
                                                                      tabBarItemInfo:popularTbiInfo];
    MIPhotosPresenter *popularPhotosPresenter = [MIPhotosPresenter new];
    MIPopularPhotosInteractor *popularPhotosInteractor = [MIPopularPhotosInteractor new];
    
    //Popular Photo Details
    MIPhotoDetailsRouter *popularPhotosDetailsRouter = [MIPhotoDetailsRouter new];
    MIPhotoDetailsPresenter *popularPhotosDetailsPresenter = [MIPhotoDetailsPresenter new];
    MIPhotoDetailsInteractor *popularPhotosDetailsInteractor = [MIPhotoDetailsInteractor new];
    
    //Popular Comments
    MICommentsRouter *popularCommentsRouter = [[MICommentsRouter alloc] initWithViewControllerIdentifier:kCommentsViewControllerIdentifier];
    MICommentsPresenter *popularCommentsPresenter = [MICommentsPresenter new];
    MICommentsInteractor *popularCommentsiInteractor = [MICommentsInteractor new];
    
    //Liked by Me
    MITabBarItemInfo *likedTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kLikedByMeTabBarItemTitle
                                                                   imageName:kLikedByMeTabBarItemImageName];
    MIPhotosRouter *likedByMeRouter = [[MIPhotosRouter new] initWithViewControllerIdentifier:kPhotosViewControllerIdentifier
                                                                          title:kLikedByMeTitle
                                                                 tabBarItemInfo:likedTbiInfo];
    MIPhotosPresenter *likedByMePresenter = [MIPhotosPresenter new];
    MILikedByMeInteractor *likedByMeInteractor = [MILikedByMeInteractor new];
    
    //LikedByMe Photo Details
    MIPhotoDetailsRouter *likedByMePhotosDetailsRouter = [MIPhotoDetailsRouter new];
    MIPhotoDetailsPresenter *likedByMePhotosDetailsPresenter = [MIPhotoDetailsPresenter new];
    MIPhotoDetailsInteractor *likedByMePhotosDetailsInteractor = [MIPhotoDetailsInteractor new];
    
    //LikedByMe Comments
    MICommentsRouter *likedByMeCommentsRouter = [[MICommentsRouter alloc] initWithViewControllerIdentifier:kCommentsViewControllerIdentifier];
    MICommentsPresenter *likedByMeCommentsPresenter = [MICommentsPresenter new];
    MICommentsInteractor *likedByMeCommentsiInteractor = [MICommentsInteractor new];
    
    //Profile
    MITabBarItemInfo *profileTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kProfileTabBarItemTitle
                                                                   imageName:kProfileTabBarItemImageName];
    MIProfileRouter *profileRouter = [[MIProfileRouter new] initWithViewControllerIdentifier:kProfileViewControllerIdentifier
                                                                       title:kProfileTitle
                                                              tabBarItemInfo:profileTbiInfo];
    MIProfilePresenter *profilePresenter = [MIProfilePresenter new];
    MIProfileInteractor *profileInteractor = [MIProfileInteractor new];
    
    //Login
    MILoginRouter *loginRouter = [MILoginRouter new];
    _loginPresenter = [MILoginPresenter new];
    MILoginInteractor *loginInteractor = [MILoginInteractor new];
    
    //Relationships
    appRouter.presenter = _appPresenter;
    appRouter.loginRouter = loginRouter;
    appRouter.innerRouters = @[popularPhotosRouter, likedByMeRouter, profileRouter];
    _appPresenter.router = appRouter;
    _appPresenter.innerPresenters = @[popularPhotosPresenter, likedByMePresenter, profilePresenter];
    
    popularPhotosRouter.presenter = popularPhotosPresenter;
    popularPhotosRouter.photoDetailsRouter = popularPhotosDetailsRouter;
    popularPhotosPresenter.router = popularPhotosRouter;
    popularPhotosPresenter.photoDetailsPresenter = popularPhotosDetailsPresenter;
    popularPhotosPresenter.interactor = popularPhotosInteractor;
    popularPhotosInteractor.presenter = popularPhotosPresenter;
    
    popularPhotosDetailsRouter.presenter = popularPhotosDetailsPresenter;
    popularPhotosDetailsRouter.commentsRouter = popularCommentsRouter;
    popularPhotosDetailsPresenter.router = popularPhotosDetailsRouter;
    popularPhotosDetailsPresenter.commentsPresenter = popularCommentsPresenter;
    popularPhotosDetailsPresenter.interactor = popularPhotosDetailsInteractor;
    popularPhotosDetailsInteractor.presenter = popularPhotosDetailsPresenter;
    
    popularCommentsRouter.presenter = popularCommentsPresenter;
    popularCommentsPresenter.router = popularCommentsRouter;
    popularCommentsPresenter.interactor = popularCommentsiInteractor;
    popularCommentsiInteractor.presenter = popularCommentsPresenter;
    
    likedByMeRouter.presenter = likedByMePresenter;
    likedByMeRouter.photoDetailsRouter = likedByMePhotosDetailsRouter;
    likedByMePresenter.router = likedByMeRouter;
    likedByMePresenter.photoDetailsPresenter = likedByMePhotosDetailsPresenter;
    likedByMePresenter.interactor = likedByMeInteractor;
    likedByMeInteractor.presenter = likedByMePresenter;
    
    likedByMePhotosDetailsRouter.presenter = likedByMePhotosDetailsPresenter;
    likedByMePhotosDetailsRouter.commentsRouter = likedByMeCommentsRouter;
    likedByMePhotosDetailsPresenter.router = likedByMePhotosDetailsRouter;
    likedByMePhotosDetailsPresenter.commentsPresenter = likedByMeCommentsPresenter;
    likedByMePhotosDetailsPresenter.interactor = likedByMePhotosDetailsInteractor;
    likedByMePhotosDetailsInteractor.presenter = likedByMePhotosDetailsPresenter;
    
    likedByMeCommentsRouter.presenter = likedByMeCommentsPresenter;
    likedByMeCommentsPresenter.router = likedByMeCommentsRouter;
    likedByMeCommentsPresenter.interactor = likedByMeCommentsiInteractor;
    likedByMeCommentsiInteractor.presenter = likedByMeCommentsPresenter;
    
    profileRouter.presenter = profilePresenter;
    profilePresenter.router = profileRouter;
    profilePresenter.appRouter = appRouter;
    profilePresenter.interactor = profileInteractor;
    profileInteractor.presenter = profilePresenter;
    
    loginRouter.presenter = _loginPresenter;
    _loginPresenter.router = loginRouter;
    _loginPresenter.appRouter = appRouter;
    _loginPresenter.interactor = loginInteractor;
    loginInteractor.presenter = _loginPresenter;
}

- (void)processResponseURL:(NSURL *)url
{
    [_appPresenter returnAppInitialState];
    [_loginPresenter processResponseWithURL:url];
    [_appPresenter performAppFirstActions];
}

- (void)installAppViewControllerToWindow:(UIWindow *)window
{
    [_appPresenter showAppViewControllerFromWindow:window];
    [_loginPresenter checkAPIRequestsAvailability];
}

@end
