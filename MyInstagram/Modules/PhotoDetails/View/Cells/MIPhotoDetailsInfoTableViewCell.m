//
//  MIPhotoDetailsInfoTableViewCell.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsInfoTableViewCell.h"

@interface MIPhotoDetailsInfoTableViewCell ()

@property (nonatomic, strong) MIInstagramPost *post;

@property (nonatomic, copy) dispatch_block_t likeButtonActionBlock;

@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (nonatomic, weak) IBOutlet UILabel *likesCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentsCountLabel;

@property (nonatomic, strong) UIImage *likeButtonImage;
@property (nonatomic, strong) UIImage *likeButtonPressedImage;

@end

@implementation MIPhotoDetailsInfoTableViewCell

#pragma mark - NSObject

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.likeButtonImage = [UIImage imageNamed:@"like_button"];
    self.likeButtonPressedImage = [UIImage imageNamed:@"like_button_pressed"];
}

#pragma mark - Actions

- (IBAction)likeButtonAction
{
    if (_likeButtonActionBlock)
    {
        _likeButtonActionBlock();
    }
}

#pragma mark - Others

- (void)configureWithPost:(MIInstagramPost *)post
    likeButtonActionBlock:(dispatch_block_t)likeButtonActionBlock
{
    self.post = post;
    
    self.likeButtonActionBlock = likeButtonActionBlock;
    
    [self setupLikeButton];
    [self setupLikesCountLabel];
    
    _commentsCountLabel.text = [NSString stringWithFormat:@"%li comments", (long)_post.commentsCount];
}

- (void)setupLikeButton
{
    UIImage *image = _post.likedByMe ? _likeButtonPressedImage : _likeButtonImage;
    
    [_likeButton setImage:image
                 forState:UIControlStateNormal];
}

- (void)setupLikesCountLabel
{
    _likesCountLabel.text = [NSString stringWithFormat:@"%li likes", (long)_post.likesCount];
}

@end
