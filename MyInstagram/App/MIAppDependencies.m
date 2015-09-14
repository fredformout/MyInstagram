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
    
    //Liked by Me
    MITabBarItemInfo *likedTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kLikedByMeTabBarItemTitle
                                                                   imageName:kLikedByMeTabBarItemImageName];
    MIPhotosRouter *likedByMeRouter = [[MIPhotosRouter new] initWithViewControllerIdentifier:kPhotosViewControllerIdentifier
                                                                          title:kLikedByMeTitle
                                                                 tabBarItemInfo:likedTbiInfo];
    MIPhotosPresenter *likedByMePresenter = [MIPhotosPresenter new];
    MILikedByMeInteractor *likedByMeInteractor = [MILikedByMeInteractor new];
    
    //Profile
    MITabBarItemInfo *profileTbiInfo = [[MITabBarItemInfo alloc] initWithTitle:kProfileTabBarItemTitle
                                                                   imageName:kProfileTabBarItemImageName];
    MIProfileRouter *profileRouter = [[MIProfileRouter new] initWithViewControllerIdentifier:kProfileViewControllerIdentifier
                                                                       title:kProfileTitle
                                                              tabBarItemInfo:profileTbiInfo];
    MIProfilePresenter *profilePresenter = [MIProfilePresenter new];
    MIProfileInteractor *profileInteractor = [MIProfileInteractor new];
    
    //Photo Details
    MIPhotoDetailsRouter *photoDetailsRouter = [MIPhotoDetailsRouter new];
    MIPhotoDetailsPresenter *photoDetailsPresenter = [MIPhotoDetailsPresenter new];
    MIPhotoDetailsInteractor *photoDetailsInteractor = [MIPhotoDetailsInteractor new];
    
    //Comments
    MICommentsRouter *commentsRouter = [[MICommentsRouter alloc] initWithViewControllerIdentifier:kCommentsViewControllerIdentifier];
    MICommentsPresenter *commentsPresenter = [MICommentsPresenter new];
    MICommentsInteractor *commentsiInteractor = [MICommentsInteractor new];
    
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
    popularPhotosRouter.photoDetailsRouter = photoDetailsRouter;
    popularPhotosPresenter.router = popularPhotosRouter;
    popularPhotosPresenter.photoDetailsPresenter = photoDetailsPresenter;
    popularPhotosPresenter.interactor = popularPhotosInteractor;
    popularPhotosInteractor.presenter = popularPhotosPresenter;
    
    likedByMeRouter.presenter = likedByMePresenter;
    likedByMeRouter.photoDetailsRouter = photoDetailsRouter;
    likedByMePresenter.router = likedByMeRouter;
    likedByMePresenter.photoDetailsPresenter = photoDetailsPresenter;
    likedByMePresenter.interactor = likedByMeInteractor;
    likedByMeInteractor.presenter = likedByMePresenter;
    
    profileRouter.presenter = profilePresenter;
    profilePresenter.router = profileRouter;
    profilePresenter.appRouter = appRouter;
    profilePresenter.interactor = profileInteractor;
    profileInteractor.presenter = profilePresenter;
    
    photoDetailsRouter.presenter = photoDetailsPresenter;
    photoDetailsRouter.commentsRouter = commentsRouter;
    photoDetailsPresenter.router = photoDetailsRouter;
    photoDetailsPresenter.commentsPresenter = commentsPresenter;
    photoDetailsPresenter.interactor = photoDetailsInteractor;
    photoDetailsInteractor.presenter = photoDetailsPresenter;
    
    commentsRouter.presenter = commentsPresenter;
    commentsPresenter.router = commentsRouter;
    commentsPresenter.interactor = commentsiInteractor;
    commentsiInteractor.presenter = commentsPresenter;
    
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
