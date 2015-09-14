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

- (NSMutableOrderedSet*)postsSet {
	[self willAccessValueForKey:@"posts"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"posts"];

	[self didAccessValueForKey:@"posts"];
	return result;
}

@end

@implementation _InstagramList (PostsCoreDataGeneratedAccessors)
- (void)addPosts:(NSOrderedSet*)value_ {
	[self.postsSet unionOrderedSet:value_];
}
- (void)removePosts:(NSOrderedSet*)value_ {
	[self.postsSet minusOrderedSet:value_];
}
- (void)addPostsObject:(InstagramPost*)value_ {
	[self.postsSet addObject:value_];
}
- (void)removePostsObject:(InstagramPost*)value_ {
	[self.postsSet removeObject:value_];
}
- (void)insertObject:(InstagramPost*)value inPostsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"posts"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self posts]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"posts"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"posts"];
}
- (void)removeObjectFromPostsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"posts"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self posts]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"posts"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"posts"];
}
- (void)insertPosts:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"posts"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self posts]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"posts"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"posts"];
}
- (void)removePostsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"posts"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self posts]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"posts"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"posts"];
}
- (void)replaceObjectInPostsAtIndex:(NSUInteger)idx withObject:(InstagramPost*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"posts"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self posts]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"posts"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"posts"];
}
- (void)replacePostsAtIndexes:(NSIndexSet *)indexes withPosts:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"posts"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self posts]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"posts"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"posts"];
}
@end

