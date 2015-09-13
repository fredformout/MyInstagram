//
//  MIPopularPhotosPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIPhotosPresenter.h"
#import "MIPhotosRouter.h"

@interface MIPhotosPresenter ()

@property (nonatomic, strong) NSMutableArray *posts;

@end

@implementation MIPhotosPresenter

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _posts = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - MIPhotosPresenterInterface

- (void)openPost:(MIInstagramPost *)post
{
    [_photoDetailsPresenter openPost:post];
    
    MIPhotosRouter *router = (MIPhotosRouter *)self.router;
    [router presentPhotoDetails];
}

- (void)initView
{
    [_controller showPosts:_posts];
}

- (void)updateView
{
    [_interactor getMorePosts];
}

- (void)reloadView
{
    [_interactor getNewPosts];
}

#pragma mark - MIPhotosInteractorOutputInterface

- (void)addPosts:(NSArray *)posts
        lastPart:(BOOL)lastPart
{
    [_posts addObjectsFromArray:posts];
    
    [_controller reload];
    [_controller stopActivityIndicatorsByType:ActivityIndicatorTypeBottom];
    
    if (lastPart)
    {
        [_controller blockBottomRefresh];
    }
}

- (void)failAddPosts
{
    [_controller stopActivityIndicatorsByType:ActivityIndicatorTypeBottom];
}

- (void)addNewPosts:(NSArray *)posts
{
    NSArray *array = [NSArray arrayWithArray:_posts];
    [_posts removeAllObjects];
    [_posts addObjectsFromArray:posts];
    [_posts addObjectsFromArray:array];
    
    [_controller reload];
    [_controller stopActivityIndicatorsByType:ActivityIndicatorTypeTop];
}

- (void)failAddNewPosts
{
    [_controller stopActivityIndicatorsByType:ActivityIndicatorTypeTop];
}

- (void)replaceAllPostsByPosts:(NSArray *)posts
                      lastPart:(BOOL)lastPart
{
    [_posts removeAllObjects];
    [_posts addObjectsFromArray:posts];
    
    [_controller reload];
    [_controller stopActivityIndicatorsByType:ActivityIndicatorTypeAll];
    
    lastPart ? [_controller blockBottomRefresh] : [_controller unblockBottomRefresh];
}

- (void)failReplaceAllPosts
{
    [_controller stopActivityIndicatorsByType:ActivityIndicatorTypeAll];
}

@end
