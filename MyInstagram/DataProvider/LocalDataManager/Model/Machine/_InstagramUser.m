// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramUser.m instead.

#import "_InstagramUser.h"

const struct InstagramUserAttributes InstagramUserAttributes = {
	.fullname = @"fullname",
	.identifier = @"identifier",
	.userPhotoURL = @"userPhotoURL",
	.username = @"username",
};

@implementation InstagramUserID
@end

@implementation _InstagramUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"InstagramUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"InstagramUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"InstagramUser" inManagedObjectContext:moc_];
}

- (InstagramUserID*)objectID {
	return (InstagramUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic fullname;

@dynamic identifier;

@dynamic userPhotoURL;

@dynamic username;

@end

