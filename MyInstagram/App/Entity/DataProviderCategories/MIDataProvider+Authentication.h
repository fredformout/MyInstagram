//
//  MIDataProvider+Authentication.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider.h"

@interface MIDataProvider (Authentication)

- (NSString *)accessToken;
- (NSURLRequest *)loginURLRequest;

- (void)startNetworkMonitoring;
- (void)logoutWithCompletion:(void(^)(BOOL success))completion;
- (void)processResponseWithURL:(NSURL *)url
                    completion:(void(^)(BOOL success))completion;

@end
