//
//  MIPhotoDetailsPhotoTableViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsPhotoTableViewCell.h"
#import "MIInstagramConstants.h"
#import "MIFileUtility.h"

@interface MIPhotoDetailsPhotoTableViewCell ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) NSString *imageName;

@end

@implementation MIPhotoDetailsPhotoTableViewCell

#pragma mark - NSObject

- (void)dealloc
{
    [self unsubscribe];
}

#pragma mark - Others

- (void)configureWithPost:(MIInstagramPost *)post
{
    self.post = post;
    
    [self setupPhoto];
}

- (void)setupPhoto
{
    [self unsubscribe];
    
    self.imageName = [NSString stringWithFormat:@"%@_%@", kStandardResolutionPhotoPattern, _post.identifier];
    UIImage *image = [UIImage imageWithContentsOfFile:[MIFileUtility pathFromDocumentsForFilename:_imageName]];
    
    if (!image)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setupPhoto)
                                                     name:_imageName
                                                   object:nil];
        
        [_activityIndicatorView startAnimating];
    }
    else
    {
        [_activityIndicatorView stopAnimating];
    }
    
    _photoImageView.image = image;
}

- (void)unsubscribe
{
    if (_imageName)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:_imageName
                                                      object:nil];
    }
}

@end
