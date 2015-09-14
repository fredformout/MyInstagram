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
    
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.layer.cornerRadius = kPhotoCornerRadius;
}

- (void)dealloc
{
    [self unsubscribe];
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
    [self unsubscribe];
    
    self.imageName = _comment.identifier ? [NSString stringWithFormat:@"%@_%@", kUserPhotoPattern, _comment.identifier] : kUserPhotoPattern;
    UIImage *image = [UIImage imageWithContentsOfFile:[MIFileUtility pathFromDocumentsForFilename:_imageName]];
    
    if (!image)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setupPhoto)
                                                     name:_imageName
                                                   object:nil];
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
