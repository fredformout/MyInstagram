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
#import "MIPhotosCollectionViewCell.h"
#import "UIViewController+InitialState.h"

static NSString *kPhotosCollectionViewCellReuseIdentifier = @"PhotosCollectionViewCell";

@interface MIPhotosCollectionViewController ()

@property (nonatomic, strong) NSArray *posts;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MIPhotosCollectionViewController
{
    BOOL viewDidAppearAtFirstTime;
    CGFloat arbitraryNumber;
    BOOL infiniteScroll;
    BOOL infiniteScrollBlocked;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_presenter initView];
    
    viewDidAppearAtFirstTime = NO;
    arbitraryNumber = [UIScreen mainScreen].bounds.size.height;
    
    [self setupRefreshControl];
    infiniteScroll = NO;
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
        
        [self firstActions];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [_posts count];
    
    infiniteScroll = (count > 0);
    
    return count;
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - arbitraryNumber;

    if (actualPosition >= contentHeight)
    {
        if (!infiniteScrollBlocked
            && infiniteScroll)
        {
            [_presenter updateView];
            
            infiniteScroll = NO;
        }
    }
}

#pragma mark - MIPhotosViewControllerInterface

- (void)showPosts:(NSArray *)posts
{
    self.posts = posts;
}

- (void)reload
{
    infiniteScroll = YES;
    
    [self.collectionView reloadData];
}

- (void)stopActivityIndicator
{
    [_refreshControl endRefreshing];
}

- (void)blockBottomRefresh
{
    infiniteScrollBlocked = YES;
}

- (void)unblockBottomRefresh
{
    infiniteScrollBlocked = NO;
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
    
    [_refreshControl endRefreshing];
    infiniteScroll = NO;
}

- (void)firstActions
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [_refreshControl beginRefreshing];
        
        [_presenter reloadView];
    });
}

#pragma mark - Others

- (void)setupRefreshControl
{
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self
                        action:@selector(reloadView)
              forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
}

- (void)reloadView
{
    [_presenter reloadView];
}

@end
