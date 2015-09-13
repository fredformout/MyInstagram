//
//  MIPhotoDetailsViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsViewController.h"

static NSString *kSegueToPhotoDetailsTableViewControllerIdentifier = @"SegueToPhotoDetailsTableViewController";

@interface MIPhotoDetailsViewController ()

@property (nonatomic, strong) MIInstagramPost *post;

@end

@implementation MIPhotoDetailsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_presenter updateView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_presenter setTransitioningDelegate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_presenter unsetTransitioningDelegate];
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueToPhotoDetailsTableViewControllerIdentifier])
    {
        MIPhotoDetailsTableViewController *tableViewController = segue.destinationViewController;
        
        self.tableViewController = tableViewController;
        tableViewController.viewController = self;
    }
}

#pragma mark - MIPhotoDetailsViewControllerInterface

- (void)showPost:(MIInstagramPost *)post
{
    self.post = post;
    self.tableViewController.post = _post;
}

- (void)reload
{
    [self.tableViewController reload];
}

- (void)undoCommentWithText:(NSString *)text
{
    self.commentTextField.text = text;
}

#pragma mark - MITransitionPhotoDetailsViewControllerInterface

- (MIPhotoDetailsPhotoTableViewCell *)tableViewCell
{
    return (MIPhotoDetailsPhotoTableViewCell *)[self.tableViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                                            inSection:0]];
}

#pragma mark - MIWithAddCommentPanelViewController

- (void)sendCommentWithText:(NSString *)text
{
    [_presenter sendCommentWithText:text];
}

@end
