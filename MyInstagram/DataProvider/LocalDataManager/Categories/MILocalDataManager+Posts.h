//
//  MILocalDataManager+Posts.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager.h"

@interface MILocalDataManager (Posts)

- (NSArray *)postsFromListWithName:(NSString *)name;
- (void)savePostsFromData:(NSArray *)data
                 listName:(NSString *)listName
                    atTop:(BOOL)atTop
               completion:(dispatch_block_t)completion;
- (void)deleteAllPostsFromListWithName:(NSString *)name
                            completion:(dispatch_block_t)completion;

@end
