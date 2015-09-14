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
#import "InstagramUser.h"
#import "InstagramPost.h"
#import "InstagramComment.h"
#import "MIConstants.h"

@interface MIMappingManager ()

@property (nonatomic, strong) NSMutableDictionary *mappings;

@end

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
        self.mappings = [NSMutableDictionary dictionary];
        
        [self createToObjectMappings];
        [self createToManagedObjectMappings];
    }
    
    return self;
}

#pragma mark - Others

- (FEMMapping *)mappingForKey:(NSString *)key
{
    return _mappings[key];
}

- (void)createToObjectMappings
{
    //UserToObjectMapping
    FEMMapping *userObjectMapping = [[FEMMapping alloc] initWithObjectClass:[MIInstagramUser class]];
    userObjectMapping.primaryKey = @"identifier";
    
    [userObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                     toKeyPath:@"id"]];
    [userObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"username"
                                                     toKeyPath:@"username"]];
    [userObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"fullname"
                                                     toKeyPath:@"full_name"]];
    [userObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"userPhotoURL"
                                                     toKeyPath:@"profile_picture"]];
    
    //CommentToObjectMapping
    FEMMapping *commentObjectMapping = [[FEMMapping alloc] initWithObjectClass:[MIInstagramComment class]];
    commentObjectMapping.primaryKey = @"identifier";
    
    [commentObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                     toKeyPath:@"id"]];
    [commentObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"date"
                                                                toKeyPath:@"created_time"
                                                                      map:^id(__nonnull id value)
    {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }
                                                               reverseMap:^id(__nonnull id value)
    {
        return [NSString stringWithFormat:@"%f", [value timeIntervalSince1970]];
    }]];
    [commentObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"text"
                                                     toKeyPath:@"text"]];
    [commentObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"username"
                                                     toKeyPath:@"from.username"]];
    [commentObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"fullname"
                                                     toKeyPath:@"from.full_name"]];
    [commentObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"userPhotoURL"
                                                     toKeyPath:@"from.profile_picture"]];
    
    //PostToObjectMapping
    FEMMapping *postObjectMapping = [[FEMMapping alloc] initWithObjectClass:[MIInstagramPost class]];
    postObjectMapping.primaryKey = @"identifier";
    
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                toKeyPath:@"id"]];
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"date"
                                                             toKeyPath:@"created_time"
                                                                   map:^id(__nonnull id value)
    {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }
                                                            reverseMap:^id(__nonnull id value)
    {
        return [NSString stringWithFormat:@"%f", [value timeIntervalSince1970]];
    }]];
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"likesCount"
                                                toKeyPath:@"likes.count"]];
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"commentsCount"
                                                toKeyPath:@"comments.count"]];
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"likedByMe"
                                                toKeyPath:@"user_has_liked"]];
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"lowResolutionPhotoURL"
                                                toKeyPath:@"images.low_resolution.url"]];
    [postObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"standardResolutionPhotoURL"
                                                toKeyPath:@"images.standard_resolution.url"]];
    
    FEMRelationship *commentsRelationship = [[FEMRelationship alloc] initWithProperty:@"comments"
                                                                              keyPath:@"comments.data"
                                                                              mapping:commentObjectMapping];
    commentsRelationship.toMany = YES;
    
    [postObjectMapping addRelationship:commentsRelationship];
    
    FEMRelationship *captionRelationship = [[FEMRelationship alloc] initWithProperty:@"caption"
                                                                             keyPath:@"caption"
                                                                             mapping:commentObjectMapping];
    
    [postObjectMapping addRelationship:captionRelationship];
    
    _mappings[kPostObjectMappingKey] = postObjectMapping;
    _mappings[kCommentObjectMappingKey] = commentObjectMapping;
    _mappings[kUserObjectMappingKey] = userObjectMapping;
}

- (void)createToManagedObjectMappings
{
    //UserToManagedObjectMapping
    FEMMapping *userManagedObjectMapping = [[FEMMapping alloc] initWithEntityName:NSStringFromClass([InstagramUser class])];
    userManagedObjectMapping.primaryKey = @"identifier";
    
    [userManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                             toKeyPath:@"id"]];
    [userManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"username"
                                                             toKeyPath:@"username"]];
    [userManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"fullname"
                                                             toKeyPath:@"full_name"]];
    [userManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"userPhotoURL"
                                                             toKeyPath:@"profile_picture"]];
    
    //CommentToManagedObjectMapping
    FEMMapping *commentManagedObjectMapping = [[FEMMapping alloc] initWithEntityName:NSStringFromClass([InstagramComment class])];
    commentManagedObjectMapping.primaryKey = @"identifier";
    
    [commentManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                                toKeyPath:@"id"]];
    [commentManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"date"
                                                                toKeyPath:@"created_time"
                                                                      map:^id(__nonnull id value)
                                           {
                                               return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                                           }
                                                                      reverseMap:^id(__nonnull id value)
                                                  {
                                                      return [NSString stringWithFormat:@"%f", [value timeIntervalSince1970]];
                                                  }]];
    [commentManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"text"
                                                                toKeyPath:@"text"]];
    [commentManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"username"
                                                                toKeyPath:@"from.username"]];
    [commentManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"fullname"
                                                                toKeyPath:@"from.full_name"]];
    [commentManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"userPhotoURL"
                                                                toKeyPath:@"from.profile_picture"]];
    
    //PostToManagedObjectMapping
    FEMMapping *postManagedObjectMapping = [[FEMMapping alloc] initWithEntityName:NSStringFromClass([InstagramPost class])];
    postManagedObjectMapping.primaryKey = @"identifier";
    
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"identifier"
                                                             toKeyPath:@"id"]];
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"date"
                                                             toKeyPath:@"created_time"
                                                                   map:^id(__nonnull id value)
                                        {
                                            return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                                        }
                                                                   reverseMap:^id(__nonnull id value)
                                               {
                                                   return [NSString stringWithFormat:@"%f", [value timeIntervalSince1970]];
                                               }]];
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"likesCount"
                                                             toKeyPath:@"likes.count"]];
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"commentsCount"
                                                             toKeyPath:@"comments.count"]];
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"likedByMe"
                                                             toKeyPath:@"user_has_liked"]];
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"lowResolutionPhotoURL"
                                                             toKeyPath:@"images.low_resolution.url"]];
    [postManagedObjectMapping addAttribute:[FEMAttribute mappingOfProperty:@"standardResolutionPhotoURL"
                                                             toKeyPath:@"images.standard_resolution.url"]];
    
    FEMRelationship *commentsRelationship = [[FEMRelationship alloc] initWithProperty:@"comments"
                                                                              keyPath:@"comments.data"
                                                                              mapping:commentManagedObjectMapping];
    commentsRelationship.toMany = YES;
    
    [postManagedObjectMapping addRelationship:commentsRelationship];
    
    FEMRelationship *captionRelationship = [[FEMRelationship alloc] initWithProperty:@"caption"
                                                                             keyPath:@"caption"
                                                                             mapping:commentManagedObjectMapping];
    
    [postManagedObjectMapping addRelationship:captionRelationship];
    
    _mappings[kPostManagedObjectMappingKey] = postManagedObjectMapping;
    _mappings[kCommentManagedObjectMappingKey] = commentManagedObjectMapping;
    _mappings[kUserManagedObjectMappingKey] = userManagedObjectMapping;
}

@end
