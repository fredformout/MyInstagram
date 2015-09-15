//
//  MIThreadSafeArray.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIUniqueOperationsArray : NSObject

- (void)addObject:(id)anObject;
- (void)removeObject:(id)anObject;
- (BOOL)containsObject:(id)anObject;

@end
