//
//  MICommentsTableViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsTableViewController.h"
#import "MICommentTableViewCell.h"
#import "MIMoreCommentsTableViewCell.h"
#import "MICommentsViewController.h"

static NSString *kCaptionTableViewCellReuseIdentifier = @"CaptionTableViewCellReuseIdentifier";
static NSString *kCommentTableViewCellReuseIdentifier = @"CommentTableViewCellReuseIdentifier";
static NSString *kMoreCommentsTableViewCellReuseIdentifier = @"MoreCommentsTableViewCellReuseIdentifier";

@interface MICommentsTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *offscreenCells;

@end

@implementation MICommentsTableViewController
{
    BOOL moreCellVisible;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UITableViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return (_post.caption ? 1 : 0) + (moreCellVisible ? 1 : 0) + [_comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = kCommentTableViewCellReuseIdentifier;
    
    if (indexPath.row == 0)
    {
        if (_post.caption)
        {
            reuseIdentifier = kCaptionTableViewCellReuseIdentifier;
        }
        else if (moreCellVisible)
        {
            reuseIdentifier = kMoreCommentsTableViewCellReuseIdentifier;
        };
    }
    else if (indexPath.row == 1
             && _post.caption
             && moreCellVisible)
    {
        reuseIdentifier = kMoreCommentsTableViewCellReuseIdentifier;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[MICommentTableViewCell class]])
    {
        MIInstagramComment *comment;
        
        if (indexPath.row == 0
            && _post.caption)
        {
            comment = _post.caption;
        }
        else
        {
            NSInteger index = indexPath.row - (moreCellVisible ? 1 : 0) - (_post.caption ? 1 : 0);
            
            comment = _comments[index];
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
    if (moreCellVisible)
    {
        if ((indexPath.row == 0
             && !_post.caption)
            || (indexPath.row == 1
                && _post.caption))
        {
            [_viewController.presenter updateView];
        }
    }
}

#pragma mark - Others

- (void)reload
{
    [self.tableView reloadData];
}

- (void)insertElementsToTopCount:(NSInteger)count
                  deleteMoreCell:(BOOL)deleteMoreCell
{
    NSMutableArray *indexPathes = [NSMutableArray array];
    NSInteger index = (_post.caption ? 1 : 0) + (moreCellVisible ? 1 : 0);
    
    for (NSInteger i = 0; i < count; i++)
    {
        [indexPathes addObject:[NSIndexPath indexPathForRow:(index + i)
                                                  inSection:0]];
    }
    
    if (deleteMoreCell)
    {
        if (moreCellVisible)
        {
            NSInteger index = _post.caption ? 1 : 0;
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:index
                                                                         inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationNone];
            
        }
    }
    
    moreCellVisible = !deleteMoreCell;
    
    [self.tableView insertRowsAtIndexPaths:indexPathes
                          withRowAnimation:UITableViewRowAnimationNone];
}

- (void)scrollToBottom
{
    NSInteger count = [self.tableView numberOfRowsInSection:0];
    
    if (count > 0)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(count - 1)
                                                                  inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
}

@end
