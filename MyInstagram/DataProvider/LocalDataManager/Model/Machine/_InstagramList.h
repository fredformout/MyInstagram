// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramList.h instead.

#import <CoreData/CoreData.h>

extern const struct InstagramListAttributes {
	__unsafe_unretained NSString *name;
} InstagramListAttributes;

extern const struct InstagramListRelationships {
	__unsafe_unretained NSString *posts;
} InstagramListRelationships;

@class InstagramPost;

@interface InstagramListID : NSManagedObjectID {}
@end

@interface _InstagramList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InstagramListID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *posts;

- (NSMutableOrderedSet*)postsSet;

@end

@interface _InstagramList (PostsCoreDataGeneratedAccessors)
- (void)addPosts:(NSOrderedSet*)value_;
- (void)removePosts:(NSOrderedSet*)value_;
- (void)addPostsObject:(InstagramPost*)value_;
- (void)removePostsObject:(InstagramPost*)value_;

- (void)insertObject:(InstagramPost*)value inPostsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPostsAtIndex:(NSUInteger)idx;
- (void)insertPosts:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePostsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPostsAtIndex:(NSUInteger)idx withObject:(InstagramPost*)value;
- (void)replacePostsAtIndexes:(NSIndexSet *)indexes withPosts:(NSArray *)values;

@end

@interface _InstagramList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableOrderedSet*)primitivePosts;
- (void)setPrimitivePosts:(NSMutableOrderedSet*)value;

@end
