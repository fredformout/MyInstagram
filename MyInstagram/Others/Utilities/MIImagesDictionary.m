//
//  MIThreadSafeDictionary.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIImagesDictionary.h"

@interface MIImagesDictionary ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation MIImagesDictionary

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Others

- (id)objectForKey:(id)aKey
{
    id returnValue;
    
    @synchronized(_dictionary)
    {
        returnValue = [_dictionary objectForKey:aKey];
    }
    
    return returnValue;
}

- (void)setObject:(id)anObject
           forKey:(id<NSCopying>)aKey
{
    @synchronized(_dictionary)
    {
        [_dictionary setObject:anObject
                        forKey:aKey];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
           [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)aKey
                                                               object:nil];
        });
    }
}

- (void)removeAllObjects
{
    @synchronized(_dictionary)
    {
        [_dictionary removeAllObjects];
    }
}

@end
