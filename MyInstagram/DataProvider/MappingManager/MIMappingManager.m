//
//  MIMappingManager.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIMappingManager.h"
#import "FEMDeserializer.h"
#import "FEMSerializer.h"

static NSString * const kObjectMappingPattern = @"Object";
static NSString * const kPostObjectMappingKey = @"PostObject";
static NSString * const kCommentObjectMappingKey = @"CommentObject";
static NSString * const kUserObjectMappingKey = @"UserObject";

static NSString * const kManagedObjectMappingPattern = @"ManagedObject";
static NSString * const kPostManagedObjectMappingKey = @"PostManagedObject";
static NSString * const kCommentManagedObjectMappingKey = @"CommentManagedObject";
static NSString * const kUserManagedObjectMappingKey = @"UserManagedObject";

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

#pragma mark - Initialization

- (void)createToObjectMappings
{
    //UserToObjectMapping
    FEMMapping *userObjectMapping = [[FEMMapping alloc] initWithObjectClass:NSClassFromString(@"MIInstagramUser")];
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
    FEMMapping *commentObjectMapping = [[FEMMapping alloc] initWithObjectClass:NSClassFromString(@"MIInstagramComment")];
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
    FEMMapping *postObjectMapping = [[FEMMapping alloc] initWithObjectClass:NSClassFromString(@"MIInstagramPost")];
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
    FEMMapping *userManagedObjectMapping = [[FEMMapping alloc] initWithEntityName:@"InstagramUser"];
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
    FEMMapping *commentManagedObjectMapping = [[FEMMapping alloc] initWithEntityName:@"InstagramComment"];
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
    FEMMapping *postManagedObjectMapping = [[FEMMapping alloc] initWithEntityName:@"InstagramPost"];
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

#pragma mark - ... from Data

- (id)objectFromData:(id)data
       mappingEntity:(NSString *)mappingEntity
{
    FEMMapping *mapping = [self objectMappingFromMappingEntity:mappingEntity];
    FEMDeserializer *deserializer = [FEMDeserializer new];

    return [deserializer objectFromRepresentation:data
                                          mapping:mapping];
}

- (id)collectionFromData:(id)data
           mappingEntity:(NSString *)mappingEntity
{
    FEMMapping *mapping = [self objectMappingFromMappingEntity:mappingEntity];
    FEMDeserializer *deserializer = [FEMDeserializer new];

    return [deserializer collectionFromRepresentation:data
                                              mapping:mapping];
}

- (void)backgroundObjectFromData:(id)data
         mappingEntity:(NSString *)mappingEntity
            completion:(MappingCompletionBlock)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        id processedData = [self objectFromData:data
                                  mappingEntity:mappingEntity];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if (completion)
            {
                completion(processedData);
            }
        });
    });
}

- (void)backgroundCollectionFromData:(id)data
             mappingEntity:(NSString *)mappingEntity
                completion:(MappingCompletionBlock)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        id processedData = [self collectionFromData:data
                                      mappingEntity:mappingEntity];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if (completion)
            {
                completion(processedData);
            }
        });
    });
}

- (id)managedObjectFromData:(id)data
              mappingEntity:(NSString *)mappingEntity
                    context:(id)context
{
    FEMMapping *mapping = [self managedObjectMappingFromMappingEntity:mappingEntity];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithContext:context];
    
    return [deserializer objectFromRepresentation:data
                                          mapping:mapping];
}

- (id)managedObjectsCollectionFromData:(id)data
                         mappingEntity:(NSString *)mappingEntity
                               context:(id)context
{
    FEMMapping *mapping = [self managedObjectMappingFromMappingEntity:mappingEntity];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithContext:context];
    
    return [deserializer collectionFromRepresentation:data
                                              mapping:mapping];
}

#pragma mark - Data from ...

- (id)dataFromObject:(id)object
       mappingEntity:(NSString *)mappingEntity
{
    return [FEMSerializer serializeObject:object
                             usingMapping:[self objectMappingFromMappingEntity:mappingEntity]];
}

- (id)dataFromCollection:(id)collection
           mappingEntity:(NSString *)mappingEntity
{
    return [FEMSerializer serializeCollection:collection
                                 usingMapping:[self objectMappingFromMappingEntity:mappingEntity]];
}

- (id)dataFromManagedObject:(id)object
              mappingEntity:(NSString *)mappingEntity
{
    return [FEMSerializer serializeObject:object
                             usingMapping:[self managedObjectMappingFromMappingEntity:mappingEntity]];
}

- (id)dataFromManagedObjectsCollection:(id)collection
                         mappingEntity:(NSString *)mappingEntity
{
    return [FEMSerializer serializeCollection:collection
                                 usingMapping:[self managedObjectMappingFromMappingEntity:mappingEntity]];
}

#pragma mark - Others

- (FEMMapping *)mappingForKey:(NSString *)key
{
    return _mappings[key];
}

- (FEMMapping *)objectMappingFromMappingEntity:(NSString *)mappingEntity
{
    return [[MIMappingManager sharedInstance] mappingForKey:[NSString stringWithFormat:@"%@%@", mappingEntity, kObjectMappingPattern]];;
}

- (FEMMapping *)managedObjectMappingFromMappingEntity:(NSString *)mappingEntity
{
    return [[MIMappingManager sharedInstance] mappingForKey:[NSString stringWithFormat:@"%@%@", mappingEntity, kManagedObjectMappingPattern]];;
}

@end
