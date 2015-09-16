//
//  MIThreadSafeArray.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIUniqueOperationsArray.h"

@interface MIUniqueOperationsArray ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation MIUniqueOperationsArray

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _array = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Others

- (void)addObject:(id)anObject
{
    @synchronized(self)
    {
        [_array addObject:anObject];
    }
}

- (void)removeObject:(id)anObject
{
    @synchronized(self)
    {
        [_array removeObject:anObject];
    }
}

- (BOOL)containsObject:(id)anObject
{
    BOOL returnValue;
    
    @synchronized(self)
    {
        returnValue = [_array containsObject:anObject];
    }
    
    return returnValue;
}

@end
