//
//  MILocalDataManager+User.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager.h"

@interface MILocalDataManager (User)

- (NSObject *)user;
- (void)saveUserFromData:(NSDictionary *)data
              completion:(dispatch_block_t)completion;

@end
