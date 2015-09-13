// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramUser.h instead.

#import <CoreData/CoreData.h>

extern const struct InstagramUserAttributes {
	__unsafe_unretained NSString *fullname;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *userPhotoPath;
	__unsafe_unretained NSString *userPhotoURL;
	__unsafe_unretained NSString *username;
} InstagramUserAttributes;

@interface InstagramUserID : NSManagedObjectID {}
@end

@interface _InstagramUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InstagramUserID* objectID;

@property (nonatomic, strong) NSString* fullname;

//- (BOOL)validateFullname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* identifier;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userPhotoPath;

//- (BOOL)validateUserPhotoPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userPhotoURL;

//- (BOOL)validateUserPhotoURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;

@end

@interface _InstagramUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFullname;
- (void)setPrimitiveFullname:(NSString*)value;

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;

- (NSString*)primitiveUserPhotoPath;
- (void)setPrimitiveUserPhotoPath:(NSString*)value;

- (NSString*)primitiveUserPhotoURL;
- (void)setPrimitiveUserPhotoURL:(NSString*)value;

- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;

@end
