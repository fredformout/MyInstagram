//
//  MIPhotoDetailsViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsTableViewController.h"
#import "MIPhotoDetailsViewController.h"
#import "MIPhotoDetailsPhotoTableViewCell.h"
#import "MIPhotoDetailsInfoTableViewCell.h"
#import "MICommentTableViewCell.h"
#import "MIMoreCommentsTableViewCell.h"

static NSInteger kCommentsThreshold = 8;
static NSInteger kCountOfBaseCells = 2;
static NSInteger kCountOfLatestComments = 3;
static CGFloat kBaseEstimatedRowHeight = 160.0;
static CGFloat kPhotoEstimatedRowHeight = 320.0;

static NSString *kPhotoDetailsPhotoTableViewCellReuseIdentifier = @"PhotoDetailsPhotoTableViewCellReuseIdentifier";
static NSString *kPhotoDetailsInfoTableViewCellReuseIdentifier = @"PhotoDetailsInfoTableViewCellReuseIdentifier";
static NSString *kCaptionTableViewCellReuseIdentifier = @"CaptionTableViewCellReuseIdentifier";
static NSString *kCommentTableViewCellReuseIdentifier = @"CommentTableViewCellReuseIdentifier";
static NSString *kMoreCommentsTableViewCellReuseIdentifier = @"MoreCommentsTableViewCellReuseIdentifier";

@interface MIPhotoDetailsTableViewController ()

@end

@implementation MIPhotoDetailsTableViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setupRefreshControl];
}

#pragma mark - UITableViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return kCountOfBaseCells + (_post.caption ? 1 : 0) + (_post.commentsCount <= kCommentsThreshold ? [_post.comments count] : (kCountOfLatestComments + 1));
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat returnValue = kBaseEstimatedRowHeight;
    
    if (indexPath.row == 0)
    {
        returnValue = kPhotoEstimatedRowHeight;
    }
    
    return returnValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL moreThanThreshold = (_post.commentsCount > kCommentsThreshold);
    
    NSString *reuseIdentifier = kCommentTableViewCellReuseIdentifier;
    
    if (indexPath.row == 0)
    {
        reuseIdentifier = kPhotoDetailsPhotoTableViewCellReuseIdentifier;
    }
    else if (indexPath.row == 1)
    {
        reuseIdentifier = kPhotoDetailsInfoTableViewCellReuseIdentifier;
    }
    else if (indexPath.row == 2
             && _post.caption)
    {
        reuseIdentifier = kCaptionTableViewCellReuseIdentifier;
    }
    else
    {
        if (moreThanThreshold)
        {
            if (indexPath.row == (_post.caption ? 3 : 2))
            {
                reuseIdentifier = kMoreCommentsTableViewCellReuseIdentifier;
            }
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[MIPhotoDetailsPhotoTableViewCell class]])
    {
        [((MIPhotoDetailsPhotoTableViewCell *)cell) configureWithPost:_post];
    }
    else if ([cell isKindOfClass:[MIPhotoDetailsInfoTableViewCell class]])
    {
        [((MIPhotoDetailsInfoTableViewCell *)cell) configureWithPost:_post
                                               likeButtonActionBlock:^
         {
             [_viewController.presenter toggleLikedByMe];
         }];
    }
    else if ([cell isKindOfClass:[MICommentTableViewCell class]])
    {
        MIInstagramComment *comment;
        
        if (indexPath.row == 2
            && _post.caption)
        {
            comment = _post.caption;
        }
        else
        {
            NSInteger index;
            
            if (moreThanThreshold)
            {
                index = indexPath.row - (_post.caption ? 4 : 3) + [_post.comments count] - kCountOfLatestComments;
            }
            else
            {
                index = indexPath.row - (_post.caption ? 3 : 2);
            }
            
            comment = _post.comments[index];
        }
        
        [((MICommentTableViewCell *)cell) configureWithComment:comment];
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - UITableViewControllerDelegate

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL moreThanThreshold = (_post.commentsCount > kCommentsThreshold);
    
    if (moreThanThreshold)
    {
        if ((indexPath.row == 2
             && !_post.caption)
            || (indexPath.row == 3
                && _post.caption))
        {
            [_viewController.presenter openComments];
        }
    }
}

#pragma mark - Others

- (void)reload
{
    [self.tableView reloadData];
    
    [self stopActivityIndicator];
}

- (void)stopActivityIndicator
{
    [self.refreshControl endRefreshing];
}

#pragma mark - Others

- (void)setupRefreshControl
{
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self
                            action:@selector(reloadView)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)reloadView
{
    [_viewController.presenter reloadView];
}

@end
