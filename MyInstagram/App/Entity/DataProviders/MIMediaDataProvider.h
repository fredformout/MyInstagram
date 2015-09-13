//
//  MIPhotosDataProvider.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseDataProvider.h"

@interface MIMediaDataProvider : MIBaseDataProvider

+ (void)getPopularPostsWithSuccessBlock:(void (^)(NSArray *data))successBlock
                           failureBlock:(void (^)(NSString *error))failureBlock;
+ (void)getPostById:(NSString *)postId
       successBlock:(void (^)(NSObject *data))successBlock
       failureBlock:(void (^)(NSString *error))failureBlock;
+ (void)getPhotoByURLString:(NSString *)URLString
                 identifier:(NSString *)identifier
               successBlock:(void (^)(NSString *filename))successBlock
               failureBlock:(void (^)(NSString *error))failureBlock;

@end
