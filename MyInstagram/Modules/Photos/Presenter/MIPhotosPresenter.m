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

#pragma mark - MIBasePresenter

- (void)returnViewControllerToInitialState
{
    [_posts removeAllObjects];
    
    [_controller reload];
    
    [super returnViewControllerToInitialState];
}

#pragma mark - MIPhotosPresenterInterface

- (void)openPost:(MIInstagramPost *)post
{
    [_photoDetailsPresenter openPost:post
                           presenter:self];
    
    MIPhotosRouter *router = (MIPhotosRouter *)self.router;
    [router presentPhotoDetails];
}

- (void)initView
{
    [_controller showPosts:_posts];
    [_interactor getLocalPosts];
}

- (void)updateView
{
    [_interactor getMorePosts];
}

- (void)reloadView
{
    if ([_interactor canMakeNetworkActivity])
    {
        [_controller startActivityIndicator];
    }
    
    [_interactor getNewPosts];
}

- (void)refreshPost:(MIInstagramPost *)oldPost
            newPost:(MIInstagramPost *)newPost
{
    if ([_posts containsObject:oldPost])
    {
        NSInteger index = [_posts indexOfObject:oldPost];
        
        if (index != NSNotFound)
        {
            [_posts replaceObjectAtIndex:index
                              withObject:newPost];
        }
    }
}

#pragma mark - MIPhotosInteractorOutputInterface

- (void)addPosts:(NSArray *)posts
        lastPart:(BOOL)lastPart
{
    [_posts addObjectsFromArray:posts];

    [_controller insertElementsToBottomCount:[posts count]];
    [_controller stopActivityIndicator];
    
    if (lastPart)
    {
        [_controller blockBottomRefresh];
    }
}

- (void)failAddPosts
{
    [_controller stopActivityIndicator];
}

- (void)replaceAllPostsByPosts:(NSArray *)posts
                      lastPart:(BOOL)lastPart
{
    [_posts removeAllObjects];
    [_posts addObjectsFromArray:posts];
    
    [_controller reload];
    [_controller stopActivityIndicator];
    
    lastPart ? [_controller blockBottomRefresh] : [_controller unblockBottomRefresh];
}

- (void)failReplaceAllPosts
{
    [_controller stopActivityIndicator];
}

@end
