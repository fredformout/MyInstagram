//
//  MILikedByMeDataProvider.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseDataProvider.h"
#import "MIInstagramUser.h"

@interface MIUsersDataProvider : MIBaseDataProvider

+ (void)getLikedByMePostsWithMaxLikeId:(NSString *)maxLikeId
                                 count:(NSInteger)count
                          successBlock:(void (^)(NSArray *data, NSString *maxLikeId))successBlock
                          failureBlock:(void (^)(NSString *error))failureBlock;
+ (void)getUserInfoWithSuccessBlock:(void (^)(NSObject *data))successBlock
                       failureBlock:(void (^)(NSString *error))failureBlock;

@end
