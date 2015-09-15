//
//  MIPhotoDetailsPhotoTableViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsPhotoTableViewCell.h"
#import "MIImageCacheUtility.h"
#import "MIFileUtility.h"

@interface MIPhotoDetailsPhotoTableViewCell ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MIPhotoDetailsPhotoTableViewCell

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

#pragma mark - Others

- (void)configureWithPost:(MIInstagramPost *)post
{
    self.post = post;
    
    [self setupPhoto];
}

- (void)setupPhoto
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupPhoto)
                                                 name:_post.standardResolutionPhotoURL
                                               object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        __block UIImage *image = [[MIImageCacheUtility sharedInstance] imageForURLString:_post.standardResolutionPhotoURL];
        
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
                    [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:_post.standardResolutionPhotoURL
                                                                                      priority:DownloadContentOperationPriorityHigh];
                });
            }
        });
    });
}

@end
