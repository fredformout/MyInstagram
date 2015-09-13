//
//  MIInstagramPost.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MIInstagramComment.h"

@interface MIInstagramPost : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL likedByMe;
@property (nonatomic, strong) UIImage *lowResolutionPhoto;
@property (nonatomic, copy) NSString *lowResolutionPhotoURL;
@property (nonatomic, copy) NSString *lowResolutionPhotoPath;
@property (nonatomic, strong) UIImage *standardResolutionPhoto;
@property (nonatomic, copy) NSString *standardResolutionPhotoURL;
@property (nonatomic, copy) NSString *standardResolutionPhotoPath;
@property (nonatomic, strong) MIInstagramComment *caption;
@property (nonatomic, copy) NSArray *comments;

@end
