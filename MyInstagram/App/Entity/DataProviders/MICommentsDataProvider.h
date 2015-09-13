//
//  MICommentsDataProvider.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseDataProvider.h"

@interface MICommentsDataProvider : MIBaseDataProvider

+ (void)getCommentsByPostId:(NSString *)postId
         lastViewedCommentId:(NSString *)lastViewedCommentId
               successBlock:(void (^)(NSArray *data))successBlock
               failureBlock:(void (^)(NSString *error))failureBlock;

+ (void)addCommentByPostId:(NSString *)postId
                      text:(NSString *)text
              successBlock:(void (^)(NSObject *data))successBlock
              failureBlock:(void (^)(NSString *error))failureBlock;

@end
