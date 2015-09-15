//
//  MIThreadSafeDictionary.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIImagesDictionary : NSObject;

- (id)objectForKey:(id)aKey;
- (void)setObject:(id)anObject
           forKey:(id<NSCopying>)aKey;
- (void)removeAllObjects;

@end
