//
//  MICommentTableViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentTableViewCell.h"
#import "MIInstagramComment.h"
#import "UIImageView+DownloadImage.h"
#import "NSDate+TimeAgo.h"

static CGFloat kPhotoCornerRadius = 3.0;

@interface MICommentTableViewCell ()

@property (nonatomic, strong) MIInstagramComment *comment;

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *fullnameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *dateActivityIndicatorView;
@property (nonatomic, weak) IBOutlet UILabel *commentTextLabel;

@end

@implementation MICommentTableViewCell

#pragma mark - NSObject

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.layer.cornerRadius = kPhotoCornerRadius;
}

#pragma mark - Others

- (void)configureWithComment:(MIInstagramComment *)comment
{
    self.comment = comment;
    
    [_photoImageView loadImageFromURL:[NSURL URLWithString:_comment.userPhotoURL]
                           cachingKey:_comment.identifier];
    _fullnameLabel.text = (_comment.fullname
                           && ![_comment.fullname isEqualToString:@""]) ? _comment.fullname : _comment.username;
    _dateLabel.text = _comment.date ? [_comment.date timeAgoSimple] : @"";
    _comment.date ? [_dateActivityIndicatorView stopAnimating] : [_dateActivityIndicatorView startAnimating];
    _commentTextLabel.text = _comment.text;
}

@end
