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

@property (nonatomic, strong) NSSet *posts;

- (NSMutableSet*)postsSet;

@end

@interface _InstagramList (PostsCoreDataGeneratedAccessors)
- (void)addPosts:(NSSet*)value_;
- (void)removePosts:(NSSet*)value_;
- (void)addPostsObject:(InstagramPost*)value_;
- (void)removePostsObject:(InstagramPost*)value_;

@end

@interface _InstagramList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitivePosts;
- (void)setPrimitivePosts:(NSMutableSet*)value;

@end
