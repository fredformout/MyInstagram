//
//  MILocalDataManager+Posts.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager+Posts.h"
#import "InstagramList.h"
#import "MagicalRecord.h"
#import "MIMappingManager.h"

@implementation MILocalDataManager (Posts)

- (NSArray *)postsFromListWithName:(NSString *)name
{
    NSArray *returnValue = nil;
    
    NSArray *lists = [InstagramList MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    
    if (lists
        && [lists count] > 0)
    {
        InstagramList *list = [lists firstObject];
        NSArray *posts = [list.posts array];
        
        NSArray *data = [[MIMappingManager sharedInstance] dataFromManagedObjectsCollection:posts
                                                                              mappingEntity:@"Post"];
        returnValue = [[MIMappingManager sharedInstance] collectionFromData:data
                                                              mappingEntity:@"Post"];
    }
    
    return returnValue;
}

- (void)savePostsFromData:(NSArray *)data
                 listName:(NSString *)listName
                    atTop:(BOOL)atTop
               completion:(dispatch_block_t)completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
     {
         NSArray *lists = [InstagramList MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", listName]
                                                       inContext:localContext];
         
         InstagramList *list;
         
         if (lists
             && [lists count] > 0)
         {
             list = [lists firstObject];
         }
         else
         {
             list = [InstagramList MR_createEntityInContext:localContext];
             
             list.name = listName;
         }
         
         NSArray *posts = [[MIMappingManager sharedInstance] managedObjectsCollectionFromData:data
                                                                                mappingEntity:@"Post"
                                                                                      context:localContext];
         
         NSOrderedSet *orderedSet;
         
         if (atTop)
         {
             orderedSet = [NSOrderedSet orderedSetWithOrderedSet:list.posts];
             
             [list removePosts:orderedSet];
         }
         
         for (InstagramPost *post in posts)
         {
             [list addPostsObject:post];
         }
         
         if (orderedSet)
         {
             [list addPosts:orderedSet];
         }
     }
                      completion:^(BOOL contextDidSave, NSError *error)
     {
         if (completion)
         {
             completion();
         }
     }];
}

- (void)deleteAllPostsFromListWithName:(NSString *)name
                            completion:(dispatch_block_t)completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
     {
         [InstagramList MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]
                                            inContext:localContext];
     }
                      completion:^(BOOL contextDidSave, NSError *error)
     {
         if (completion)
         {
             completion();
         }
     }];
}

@end
