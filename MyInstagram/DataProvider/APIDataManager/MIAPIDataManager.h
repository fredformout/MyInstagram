//
//  MIAPIDataManager.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIAPIBaseRequest.h"

typedef void (^RequestSuccessBlock)(id data);
typedef void (^RequestFailureBlock)(id error);

@interface MIAPIDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)startRequest:(MIAPIBaseRequest *)request;
- (NSMutableURLRequest *)URLRequestWithRequest:(MIAPIBaseRequest *)request;
- (BOOL)isReachable;

@end
