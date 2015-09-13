// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramComment.m instead.

#import "_InstagramComment.h"

const struct InstagramCommentAttributes InstagramCommentAttributes = {
	.date = @"date",
	.fullname = @"fullname",
	.identifier = @"identifier",
	.text = @"text",
	.userPhotoPath = @"userPhotoPath",
	.userPhotoURL = @"userPhotoURL",
	.username = @"username",
};

const struct InstagramCommentRelationships InstagramCommentRelationships = {
	.post = @"post",
	.postForWhichIsCaption = @"postForWhichIsCaption",
};

@implementation InstagramCommentID
@end

@implementation _InstagramComment

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"InstagramComment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"InstagramComment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"InstagramComment" inManagedObjectContext:moc_];
}

- (InstagramCommentID*)objectID {
	return (InstagramCommentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic date;

@dynamic fullname;

@dynamic identifier;

@dynamic text;

@dynamic userPhotoPath;

@dynamic userPhotoURL;

@dynamic username;

@dynamic post;

@dynamic postForWhichIsCaption;

@end

