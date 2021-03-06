//
//  MIDataProvider+Comments.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider.h"

@interface MIDataProvider (Comments)

- (void)getCommentsByPostId:(NSString *)postId
                      maxId:(NSString *)maxId
               successBlock:(void (^)(NSArray *data, NSString *maxId))successBlock
               failureBlock:(void (^)(NSString *error))failureBlock;
- (void)addCommentByPostId:(NSString *)postId
                      text:(NSString *)text
              successBlock:(void (^)(NSObject *data))successBlock
              failureBlock:(void (^)(NSString *error))failureBlock;

@end
