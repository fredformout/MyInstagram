//
//  MICommentsViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsViewController.h"

static NSString *kSegueToCommentsTableViewControllerIdentifier = @"SegueToCommentsTableViewController";

@interface MICommentsViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, weak) MIInstagramPost *post;
@property (nonatomic, weak) NSArray *comments;

@end

@implementation MICommentsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewController.tableView.hidden = YES;
    [_activityIndicatorView startAnimating];
    
    [_presenter updateView];
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueToCommentsTableViewControllerIdentifier])
    {
        MICommentsTableViewController *tableViewController = segue.destinationViewController;
        
        self.tableViewController = tableViewController;
        tableViewController.viewController = self;
    }
}

#pragma nark - MICommentsViewControllerInterface

- (void)insertElementsToTopCount:(NSInteger)count
                  deleteMoreCell:(BOOL)deleteMoreCell
{
    [self.tableViewController insertElementsToTopCount:count
                                        deleteMoreCell:deleteMoreCell];
    
    [self.tableViewController scrollToBottom];
    
    [_activityIndicatorView stopAnimating];
    self.tableViewController.tableView.hidden = NO;
}

- (void)showComments:(NSArray *)comments
                post:(MIInstagramPost *)post
{
    self.post = post;
    self.comments = comments;
    _tableViewController.post = _post;
    _tableViewController.comments = _comments;
}

- (void)reload
{
    [self.tableViewController reload];
}

#pragma mark - MIWithAddCommentPanelViewController

- (void)sendCommentWithText:(NSString *)text
{
    [_presenter sendCommentWithText:text];
}

#pragma mark - MIAddCommentViewControllerInterface

- (void)undoCommentWithText:(NSString *)text
{
    self.commentTextField.text = text;
}

@end
