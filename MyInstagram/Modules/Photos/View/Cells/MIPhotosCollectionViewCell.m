//
//  MIPopularPhotosCollectionViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosCollectionViewCell.h"
#import "MIInstagramConstants.h"
#import "MIImageCacheUtility.h"
#import "MIFileUtility.h"

@interface MIPhotosCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MIPhotosCollectionViewCell

#pragma mark - NSObject

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UICollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _photoImageView.image = nil;
    _photoImageView.hidden = NO;
}

#pragma mark - Others

- (void)configureCellWithPost:(MIInstagramPost *)post
{
    self.post = post;
    
    [self setupPhoto];
}

- (void)setupPhoto
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupPhoto)
                                                 name:_post.lowResolutionPhotoURL
                                               object:nil];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        __block UIImage *image = [[MIImageCacheUtility sharedInstance] imageForURLString:_post.lowResolutionPhotoURL];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if (image)
            {
                [[NSNotificationCenter defaultCenter] removeObserver:self];
                
                [_activityIndicatorView stopAnimating];
                _photoImageView.image = image;
            }
            else
            {
                _photoImageView.image = nil;
                [_activityIndicatorView startAnimating];
            
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                {
                    [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:_post.lowResolutionPhotoURL
                                                                                          priority:DownloadContentOperationPriorityHigh];
                    [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:_post.standardResolutionPhotoURL
                                                                                          priority:DownloadContentOperationPriorityHigh];
                    [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:_post.caption.username
                                                                                          priority:DownloadContentOperationPriorityLow];
                    
                    for (MIInstagramComment *comment in _post.comments)
                    {
                        [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:comment.username
                                                                                              priority:DownloadContentOperationPriorityLow];
                    }
                });
            }
        });
    });
}

- (void)assignImageWithNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_activityIndicatorView stopAnimating];
    _photoImageView.image = notification.object;
}

@end
