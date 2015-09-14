//
//  MIAPIDataManager.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIAPIRequest.h"

typedef void (^RequestSuccessBlock)(id data);
typedef void (^RequestFailureBlock)(id error);

@interface MIAPIDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)startOperationWithRequest:(MIAPIRequest *)request;
- (void)cancelAllOperations;

- (NSMutableURLRequest *)URLRequestWithRequest:(MIAPIRequest *)request;
- (BOOL)isReachable;

@end
