// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramComment.h instead.

#import <CoreData/CoreData.h>

extern const struct InstagramCommentAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *fullname;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *userPhotoURL;
	__unsafe_unretained NSString *username;
} InstagramCommentAttributes;

extern const struct InstagramCommentRelationships {
	__unsafe_unretained NSString *post;
	__unsafe_unretained NSString *postForWhichIsCaption;
} InstagramCommentRelationships;

@class InstagramPost;
@class InstagramPost;

@interface InstagramCommentID : NSManagedObjectID {}
@end

@interface _InstagramComment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InstagramCommentID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* fullname;

//- (BOOL)validateFullname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* identifier;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userPhotoURL;

//- (BOOL)validateUserPhotoURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) InstagramPost *post;

//- (BOOL)validatePost:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) InstagramPost *postForWhichIsCaption;

//- (BOOL)validatePostForWhichIsCaption:(id*)value_ error:(NSError**)error_;

@end

@interface _InstagramComment (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveFullname;
- (void)setPrimitiveFullname:(NSString*)value;

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSString*)primitiveUserPhotoURL;
- (void)setPrimitiveUserPhotoURL:(NSString*)value;

- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;

- (InstagramPost*)primitivePost;
- (void)setPrimitivePost:(InstagramPost*)value;

- (InstagramPost*)primitivePostForWhichIsCaption;
- (void)setPrimitivePostForWhichIsCaption:(InstagramPost*)value;

@end
