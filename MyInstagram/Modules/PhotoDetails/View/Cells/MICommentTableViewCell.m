//
//  MICommentTableViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentTableViewCell.h"
#import "MIInstagramComment.h"
#import "NSDate+TimeAgo.h"
#import "MIInstagramConstants.h"
#import "MIFileUtility.h"
#import "MIImageCacheUtility.h"

static CGFloat kPhotoCornerRadius = 3.0;

@interface MICommentTableViewCell ()

@property (nonatomic, strong) MIInstagramComment *comment;

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *fullnameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *dateActivityIndicatorView;
@property (nonatomic, weak) IBOutlet UILabel *commentTextLabel;

@property (nonatomic, strong) NSString *imageName;

@end

@implementation MICommentTableViewCell

#pragma mark - NSObject

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
    
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.layer.cornerRadius = kPhotoCornerRadius;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Others

- (void)configureWithComment:(MIInstagramComment *)comment
{
    self.comment = comment;
    
    [self setupPhoto];
    
    _fullnameLabel.text = (_comment.fullname
                           && ![_comment.fullname isEqualToString:@""]) ? _comment.fullname : _comment.username;
    _dateLabel.text = _comment.date ? [_comment.date timeAgoSimple] : @"";
    _comment.date ? [_dateActivityIndicatorView stopAnimating] : [_dateActivityIndicatorView startAnimating];
    _commentTextLabel.text = _comment.text;
}

- (void)setupPhoto
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupPhoto)
                                                 name:_comment.userPhotoURL
                                               object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        __block UIImage *image = [[MIImageCacheUtility sharedInstance] imageForURLString:_comment.userPhotoURL];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if (image)
            {
                [[NSNotificationCenter defaultCenter] removeObserver:self];
                
                _photoImageView.image = image;
            }
            else
            {
                _photoImageView.image = nil;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                {
                    [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:_comment.userPhotoURL
                                                                                      priority:DownloadContentOperationPriorityLow];
                });
            }
        });
    });
}

@end
