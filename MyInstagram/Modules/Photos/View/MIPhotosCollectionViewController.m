//
//  MIPopularPhotosViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosCollectionViewController.h"
#import "Macro.h"
#import "MITransitionFromPhotosToPhotoDetails.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "MIPhotosCollectionViewCell.h"
#import "UIViewController+InitialState.h"

static NSString *kPhotosCollectionViewCellReuseIdentifier = @"PhotosCollectionViewCell";

@interface MIPhotosCollectionViewController ()

@property (nonatomic, strong) NSArray *posts;

@end

@implementation MIPhotosCollectionViewController
{
    BOOL viewDidAppearAtFirstTime;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_presenter initView];
    
    viewDidAppearAtFirstTime = NO;
    
    __weak typeof(self) weakSelf = self;
    
    [self.collectionView addPullToRefreshWithActionHandler:^
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter reloadView];
    }];
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter updateView];
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat widthOfCollectionView = CGRectGetWidth(self.collectionView.frame);
    NSInteger columnsCount = IS_IPHONE_6P ? 3 : 2;
    
    CGFloat cellWidth = widthOfCollectionView / columnsCount;
    
    ((UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout).itemSize = CGSizeMake(cellWidth, cellWidth);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!viewDidAppearAtFirstTime)
    {
        viewDidAppearAtFirstTime = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
        {
            [self.collectionView.pullToRefreshView startAnimating];
            
            [_presenter reloadView];
        });
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [_posts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MIPhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotosCollectionViewCellReuseIdentifier
                                                                                 forIndexPath:indexPath];
    
    MIInstagramPost *post = _posts[indexPath.row];
    
    [cell configureCellWithPost:post];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_presenter openPost:_posts[indexPath.row]];
}

#pragma mark - MIPhotosViewControllerInterface

- (void)showPosts:(NSArray *)posts
{
    self.posts = posts;
}

- (void)reload
{
    [self.collectionView reloadData];
}

- (void)stopActivityIndicatorsByType:(ActivityIndicatorType)activityIndicatorType
{
    [self.collectionView performBatchUpdates:^{}
                                  completion:^(BOOL finished)
    {
        switch (activityIndicatorType)
        {
            case ActivityIndicatorTypeTop:
                [self.collectionView.pullToRefreshView stopAnimating];
                break;
            case ActivityIndicatorTypeBottom:
                [self.collectionView.infiniteScrollingView stopAnimating];
                break;
            case ActivityIndicatorTypeAll:
            {
                [self.collectionView.pullToRefreshView stopAnimating];
                [self.collectionView.infiniteScrollingView stopAnimating];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)blockTopRefresh
{
    [self.collectionView performBatchUpdates:^{}
                                  completion:^(BOOL finished)
    {
        self.collectionView.showsPullToRefresh = NO;
    }];
}

- (void)blockBottomRefresh
{
    [self.collectionView performBatchUpdates:^{}
                                  completion:^(BOOL finished)
    {
        self.collectionView.showsInfiniteScrolling = NO;
    }];
}

- (void)unblockTopRefresh
{
    [self.collectionView performBatchUpdates:^{}
                                  completion:^(BOOL finished)
    {
        self.collectionView.showsPullToRefresh = YES;
    }];
}

- (void)unblockBottomRefresh
{
    [self.collectionView performBatchUpdates:^{}
                                  completion:^(BOOL finished)
    {
        self.collectionView.showsInfiniteScrolling = YES;
    }];
}

#pragma mark - MITransitionPhotosViewControllerInterface

- (MIPhotosCollectionViewCell *)collectionViewCellForPost:(MIInstagramPost *)post
{
    NSUInteger postIndex = [_posts indexOfObject:post];
    
    if (postIndex == NSNotFound)
    {
        return nil;
    }
    
    return (MIPhotosCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:postIndex
                                                                                                    inSection:0]];
}

#pragma mark - UIViewController+InitialState

- (void)returnToInitialState
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [self.collectionView.pullToRefreshView stopAnimating];
    [self.collectionView.infiniteScrollingView stopAnimating];
    
    viewDidAppearAtFirstTime = NO;
}

@end
