//
//  MILikesDataProvider.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 12.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseDataProvider.h"

@interface MILikesDataProvider : MIBaseDataProvider

+ (void)likePostByPostId:(NSString *)postId
            successBlock:(void (^)(NSObject *data))successBlock
            failureBlock:(void (^)(NSString *error))failureBlock;
+ (void)unlikePostByPostId:(NSString *)postId
              successBlock:(void (^)(NSObject *data))successBlock
              failureBlock:(void (^)(NSString *error))failureBlock;

@end
