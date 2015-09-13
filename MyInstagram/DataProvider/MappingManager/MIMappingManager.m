//
//  MIMappingManager.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIMappingManager.h"
#import "MIInstagramUser.h"
#import "MIInstagramPost.h"
#import "MIInstagramComment.h"

@implementation MIMappingManager

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static MIMappingManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [MIMappingManager new];
    });
    
    return _sharedInstance;
}

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self createMappings];
    }
    
    return self;
}

#pragma mark - Others

- (void)createMappings
{
    _userMapping = [[FEMMapping alloc] initWithObjectClass:[MIInstagramUser class]];
    _userMapping.primaryKey = @"identifier";
    
    [_userMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                     toKeyPath:@"id"]];
    [_userMapping addAttribute:[FEMAttribute mappingOfProperty:@"username"
                                                     toKeyPath:@"username"]];
    [_userMapping addAttribute:[FEMAttribute mappingOfProperty:@"fullname"
                                                     toKeyPath:@"full_name"]];
    [_userMapping addAttribute:[FEMAttribute mappingOfProperty:@"userPhotoURL"
                                                     toKeyPath:@"profile_picture"]];
    
    _commentMapping = [[FEMMapping alloc] initWithObjectClass:[MIInstagramComment class]];
    _commentMapping.primaryKey = @"identifier";
    
    [_commentMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                     toKeyPath:@"id"]];
    [_commentMapping addAttribute:[FEMAttribute mappingOfProperty:@"date"
                                                     toKeyPath:@"created_time"
                                                           map:^id(__nonnull id value)
    {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }]];
    [_commentMapping addAttribute:[FEMAttribute mappingOfProperty:@"text"
                                                     toKeyPath:@"text"]];
    [_commentMapping addAttribute:[FEMAttribute mappingOfProperty:@"username"
                                                     toKeyPath:@"from.username"]];
    [_commentMapping addAttribute:[FEMAttribute mappingOfProperty:@"fullname"
                                                     toKeyPath:@"from.full_name"]];
    [_commentMapping addAttribute:[FEMAttribute mappingOfProperty:@"userPhotoURL"
                                                     toKeyPath:@"from.profile_picture"]];
    
    _postMapping = [[FEMMapping alloc] initWithObjectClass:[MIInstagramPost class]];
    _postMapping.primaryKey = @"identifier";
    
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                toKeyPath:@"id"]];
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"date"
                                                toKeyPath:@"created_time"
                                                      map:^id(__nonnull id value)
    {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }]];
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"likesCount"
                                                toKeyPath:@"likes.count"]];
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"commentsCount"
                                                toKeyPath:@"comments.count"]];
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"likedByMe"
                                                toKeyPath:@"user_has_liked"]];
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"lowResolutionPhotoURL"
                                                toKeyPath:@"images.low_resolution.url"]];
    [_postMapping addAttribute:[FEMAttribute mappingOfProperty:@"standardResolutionPhotoURL"
                                                toKeyPath:@"images.standard_resolution.url"]];
    
    FEMRelationship *commentsRelationship = [[FEMRelationship alloc] initWithProperty:@"comments"
                                                                              keyPath:@"comments.data"
                                                                              mapping:_commentMapping];
    commentsRelationship.toMany = YES;
    
    [_postMapping addRelationship:commentsRelationship];
    
    FEMRelationship *captionRelationship = [[FEMRelationship alloc] initWithProperty:@"caption"
                                                                             keyPath:@"caption"
                                                                             mapping:_commentMapping];
    
    [_postMapping addRelationship:captionRelationship];
}

@end
