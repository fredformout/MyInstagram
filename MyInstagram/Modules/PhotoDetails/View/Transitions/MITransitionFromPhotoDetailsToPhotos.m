//
//  MITransitionFromPhotoDetails.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MITransitionFromPhotoDetailsToPhotos.h"
#import "MITransitionPhotoDetailsViewControllerInterface.h"
#import "MITransitionPhotosViewControllerInterface.h"
#import "MIPhotoDetailsPhotoTableViewCell.h"
#import "MIPhotosCollectionViewCell.h"

@implementation MITransitionFromPhotoDetailsToPhotos

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    id<MITransitionPhotoDetailsViewControllerInterface> fromVC = (id<MITransitionPhotoDetailsViewControllerInterface>)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    id<MITransitionPhotosViewControllerInterface> toVC = (id<MITransitionPhotosViewControllerInterface>)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    MIPhotoDetailsPhotoTableViewCell *fromCell = [fromVC tableViewCell];
    
    UIView *imageSnapshot = [fromCell.photoImageView snapshotViewAfterScreenUpdates:NO];
    
    imageSnapshot.frame = [containerView convertRect:fromCell.photoImageView.frame
                                            fromView:fromCell.photoImageView.superview];
    fromCell.photoImageView.hidden = YES;
    
    MIPhotosCollectionViewCell *toCell = [toVC collectionViewCellForPost:fromCell.post];
    toCell.photoImageView.hidden = YES;
    
    ((UIViewController *)toVC).view.frame = [transitionContext finalFrameForViewController:(UIViewController *)toVC];
    [containerView insertSubview:((UIViewController *)toVC).view
                    belowSubview:((UIViewController *)fromVC).view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^
    {
        ((UIViewController *)fromVC).view.alpha = 0.0;
        
        imageSnapshot.frame = [containerView convertRect:toCell.photoImageView.frame
                                                fromView:toCell.photoImageView.superview];
    }
                     completion:^(BOOL finished)
    {
        [imageSnapshot removeFromSuperview];
        fromCell.photoImageView.hidden = NO;
        toCell.photoImageView.hidden = NO;
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

@end
