//
//  MIDataProvider+User.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider.h"

@interface MIDataProvider (User)

- (NSObject *)localUser;
- (void)getUserInfoWithSuccessBlock:(void (^)(NSObject *data))successBlock
                       failureBlock:(void (^)(NSString *error))failureBlock;

@end
