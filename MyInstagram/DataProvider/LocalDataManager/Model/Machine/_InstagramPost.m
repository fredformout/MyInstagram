// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramPost.m instead.

#import "_InstagramPost.h"

const struct InstagramPostAttributes InstagramPostAttributes = {
	.commentsCount = @"commentsCount",
	.date = @"date",
	.identifier = @"identifier",
	.likedByMe = @"likedByMe",
	.likesCount = @"likesCount",
	.lowResolutionPhotoURL = @"lowResolutionPhotoURL",
	.standardResolutionPhotoURL = @"standardResolutionPhotoURL",
};

const struct InstagramPostRelationships InstagramPostRelationships = {
	.caption = @"caption",
	.comments = @"comments",
	.list = @"list",
};

@implementation InstagramPostID
@end

@implementation _InstagramPost

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"InstagramPost" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"InstagramPost";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"InstagramPost" inManagedObjectContext:moc_];
}

- (InstagramPostID*)objectID {
	return (InstagramPostID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"commentsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"commentsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"likedByMeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"likedByMe"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"likesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"likesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic commentsCount;

- (int64_t)commentsCountValue {
	NSNumber *result = [self commentsCount];
	return [result longLongValue];
}

- (void)setCommentsCountValue:(int64_t)value_ {
	[self setCommentsCount:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCommentsCountValue {
	NSNumber *result = [self primitiveCommentsCount];
	return [result longLongValue];
}

- (void)setPrimitiveCommentsCountValue:(int64_t)value_ {
	[self setPrimitiveCommentsCount:[NSNumber numberWithLongLong:value_]];
}

@dynamic date;

@dynamic identifier;

@dynamic likedByMe;

- (BOOL)likedByMeValue {
	NSNumber *result = [self likedByMe];
	return [result boolValue];
}

- (void)setLikedByMeValue:(BOOL)value_ {
	[self setLikedByMe:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveLikedByMeValue {
	NSNumber *result = [self primitiveLikedByMe];
	return [result boolValue];
}

- (void)setPrimitiveLikedByMeValue:(BOOL)value_ {
	[self setPrimitiveLikedByMe:[NSNumber numberWithBool:value_]];
}

@dynamic likesCount;

- (int64_t)likesCountValue {
	NSNumber *result = [self likesCount];
	return [result longLongValue];
}

- (void)setLikesCountValue:(int64_t)value_ {
	[self setLikesCount:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveLikesCountValue {
	NSNumber *result = [self primitiveLikesCount];
	return [result longLongValue];
}

- (void)setPrimitiveLikesCountValue:(int64_t)value_ {
	[self setPrimitiveLikesCount:[NSNumber numberWithLongLong:value_]];
}

@dynamic lowResolutionPhotoURL;

@dynamic standardResolutionPhotoURL;

@dynamic caption;

@dynamic comments;

- (NSMutableSet*)commentsSet {
	[self willAccessValueForKey:@"comments"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"comments"];

	[self didAccessValueForKey:@"comments"];
	return result;
}

@dynamic list;

@end

