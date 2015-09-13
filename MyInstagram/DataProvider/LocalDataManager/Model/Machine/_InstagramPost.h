// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramPost.h instead.

#import <CoreData/CoreData.h>

extern const struct InstagramPostAttributes {
	__unsafe_unretained NSString *commentsCount;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *likedByMe;
	__unsafe_unretained NSString *likesCount;
	__unsafe_unretained NSString *lowResolutionPhotoPath;
	__unsafe_unretained NSString *lowResolutionPhotoURL;
	__unsafe_unretained NSString *standardPhotoPath;
	__unsafe_unretained NSString *standardPhotoURL;
} InstagramPostAttributes;

extern const struct InstagramPostRelationships {
	__unsafe_unretained NSString *caption;
	__unsafe_unretained NSString *comments;
	__unsafe_unretained NSString *list;
} InstagramPostRelationships;

@class InstagramComment;
@class InstagramComment;
@class InstagramList;

@interface InstagramPostID : NSManagedObjectID {}
@end

@interface _InstagramPost : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InstagramPostID* objectID;

@property (nonatomic, strong) NSNumber* commentsCount;

@property (atomic) int64_t commentsCountValue;
- (int64_t)commentsCountValue;
- (void)setCommentsCountValue:(int64_t)value_;

//- (BOOL)validateCommentsCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* identifier;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* likedByMe;

@property (atomic) BOOL likedByMeValue;
- (BOOL)likedByMeValue;
- (void)setLikedByMeValue:(BOOL)value_;

//- (BOOL)validateLikedByMe:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* likesCount;

@property (atomic) int64_t likesCountValue;
- (int64_t)likesCountValue;
- (void)setLikesCountValue:(int64_t)value_;

//- (BOOL)validateLikesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lowResolutionPhotoPath;

//- (BOOL)validateLowResolutionPhotoPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lowResolutionPhotoURL;

//- (BOOL)validateLowResolutionPhotoURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* standardPhotoPath;

//- (BOOL)validateStandardPhotoPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* standardPhotoURL;

//- (BOOL)validateStandardPhotoURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) InstagramComment *caption;

//- (BOOL)validateCaption:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *comments;

- (NSMutableSet*)commentsSet;

@property (nonatomic, strong) InstagramList *list;

//- (BOOL)validateList:(id*)value_ error:(NSError**)error_;

@end

@interface _InstagramPost (CommentsCoreDataGeneratedAccessors)
- (void)addComments:(NSSet*)value_;
- (void)removeComments:(NSSet*)value_;
- (void)addCommentsObject:(InstagramComment*)value_;
- (void)removeCommentsObject:(InstagramComment*)value_;

@end

@interface _InstagramPost (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCommentsCount;
- (void)setPrimitiveCommentsCount:(NSNumber*)value;

- (int64_t)primitiveCommentsCountValue;
- (void)setPrimitiveCommentsCountValue:(int64_t)value_;

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;

- (NSNumber*)primitiveLikedByMe;
- (void)setPrimitiveLikedByMe:(NSNumber*)value;

- (BOOL)primitiveLikedByMeValue;
- (void)setPrimitiveLikedByMeValue:(BOOL)value_;

- (NSNumber*)primitiveLikesCount;
- (void)setPrimitiveLikesCount:(NSNumber*)value;

- (int64_t)primitiveLikesCountValue;
- (void)setPrimitiveLikesCountValue:(int64_t)value_;

- (NSString*)primitiveLowResolutionPhotoPath;
- (void)setPrimitiveLowResolutionPhotoPath:(NSString*)value;

- (NSString*)primitiveLowResolutionPhotoURL;
- (void)setPrimitiveLowResolutionPhotoURL:(NSString*)value;

- (NSString*)primitiveStandardPhotoPath;
- (void)setPrimitiveStandardPhotoPath:(NSString*)value;

- (NSString*)primitiveStandardPhotoURL;
- (void)setPrimitiveStandardPhotoURL:(NSString*)value;

- (InstagramComment*)primitiveCaption;
- (void)setPrimitiveCaption:(InstagramComment*)value;

- (NSMutableSet*)primitiveComments;
- (void)setPrimitiveComments:(NSMutableSet*)value;

- (InstagramList*)primitiveList;
- (void)setPrimitiveList:(InstagramList*)value;

@end
