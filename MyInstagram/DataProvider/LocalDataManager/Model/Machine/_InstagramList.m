// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InstagramList.m instead.

#import "_InstagramList.h"

const struct InstagramListAttributes InstagramListAttributes = {
	.name = @"name",
};

const struct InstagramListRelationships InstagramListRelationships = {
	.posts = @"posts",
};

@implementation InstagramListID
@end

@implementation _InstagramList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"InstagramList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"InstagramList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"InstagramList" inManagedObjectContext:moc_];
}

- (InstagramListID*)objectID {
	return (InstagramListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic posts;

- (NSMutableSet*)postsSet {
	[self willAccessValueForKey:@"posts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"posts"];

	[self didAccessValueForKey:@"posts"];
	return result;
}

@end

