//
//  MILoginDataProvider.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBaseDataProvider.h"

@interface MIAuthenticationDataProvider : MIBaseDataProvider

+ (void)startNetworkMonitoring;
+ (NSString *)accessToken;
+ (NSURLRequest *)loginURLRequest;
+ (void)logoutWithCompletion:(void(^)(BOOL success))completion;
+ (void)processResponseWithURL:(NSURL *)url
                    completion:(void(^)(BOOL success))completion;

@end
