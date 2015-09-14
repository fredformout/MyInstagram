//
//  MIDataProvider+Posts.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider.h"

@interface MIDataProvider (Posts)

- (NSArray *)localPopularPosts;
- (void)getPopularPostsWithSuccessBlock:(void (^)(NSArray *data))successBlock
                           failureBlock:(void (^)(NSString *error))failureBlock;

- (NSArray *)localLikedByMePosts;
- (void)getLikedByMePostsWithMaxLikeId:(NSString *)maxLikeId
                                 count:(NSInteger)count
                          successBlock:(void (^)(NSArray *data, NSString *maxLikeId))successBlock
                          failureBlock:(void (^)(NSString *error))failureBlock;

- (void)getPostById:(NSString *)postId
       successBlock:(void (^)(NSObject *data))successBlock
       failureBlock:(void (^)(NSString *error))failureBlock;

@end
