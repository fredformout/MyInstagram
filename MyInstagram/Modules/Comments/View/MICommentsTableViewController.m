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

static CGFloat kEstimatedRowHeight = 100.0;

static NSString *kCaptionTableViewCellReuseIdentifier = @"CaptionTableViewCellReuseIdentifier";
static NSString *kCommentTableViewCellReuseIdentifier = @"CommentTableViewCellReuseIdentifier";
static NSString *kMoreCommentsTableViewCellReuseIdentifier = @"MoreCommentsTableViewCellReuseIdentifier";

@implementation MICommentsTableViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = kEstimatedRowHeight;
}

#pragma mark - UITableViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_comments count] + (_post.caption ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = nil;
    MIInstagramComment *comment;
    
    if (indexPath.row == 0
        && _post.caption)
    {
        reuseIdentifier = kCaptionTableViewCellReuseIdentifier;
        comment = _post.caption;
    }
    else
    {
        reuseIdentifier = kCommentTableViewCellReuseIdentifier;
        
        NSInteger index = indexPath.row - (_post.caption ? 1 : 0);
        
        comment = _comments[index];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    
    [((MICommentTableViewCell *)cell) configureWithComment:comment];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - Others

- (void)reload
{
    [self.tableView reloadData];
    [self scrollToBottom];
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
