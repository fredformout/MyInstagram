//
//  MITransitionToPhotoDetails.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MITransitionFromPhotosToPhotoDetails.h"
#import "MITransitionPhotosViewControllerInterface.h"
#import "MITransitionPhotoDetailsViewControllerInterface.h"
#import "MIPhotosCollectionViewCell.h"
#import "MIPhotoDetailsPhotoTableViewCell.h"

@implementation MITransitionFromPhotosToPhotoDetails

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    id<MITransitionPhotosViewControllerInterface> fromVC = (id<MITransitionPhotosViewControllerInterface>)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    id<MITransitionPhotoDetailsViewControllerInterface> toVC = (id<MITransitionPhotoDetailsViewControllerInterface>)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    MIPhotosCollectionViewCell *fromCell = (MIPhotosCollectionViewCell *)[((UICollectionViewController *)fromVC).collectionView cellForItemAtIndexPath:[[((UICollectionViewController *)fromVC).collectionView indexPathsForSelectedItems] firstObject]];
    
    UIView *cellImageSnapshot = [fromCell.photoImageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:fromCell.photoImageView.frame
                                                fromView:fromCell.photoImageView.superview];
    
    fromCell.photoImageView.hidden = YES;
    
    ((UIViewController *)toVC).view.frame = [transitionContext finalFrameForViewController:(UIViewController *)toVC];
    ((UIViewController *)toVC).view.alpha = 0;
    
    MIPhotoDetailsPhotoTableViewCell *toCell = [toVC tableViewCell];
    toCell.photoImageView.hidden = YES;
    
    [containerView addSubview:((UIViewController *)toVC).view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^
    {
        ((UIViewController *)toVC).view.alpha = 1.0;
        
        CGRect toViewFrame = ((UIViewController *)toVC).view.bounds;
        toViewFrame.size.height = toViewFrame.size.width;
        
        CGRect frame = [containerView convertRect:toViewFrame
                                         fromView:((UIViewController *)toVC).view];
        
        cellImageSnapshot.frame = frame;
    }
                     completion:^(BOOL finished)
    {
        toCell.photoImageView.hidden = NO;
        fromCell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

@end
