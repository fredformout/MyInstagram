//
//  MIDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseDataProvider.h"
#import "UICKeyChainStore+SharedInstance.h"
#import "MIAPIDataManager.h"
#import "MIInstagramConstants.h"
#import "MIAPIBaseRequest.h"

@implementation MIBaseDataProvider

+ (BOOL)canMakeRequest
{
    return [UICKeyChainStore sharedInstance][kAccessTokenKey]
    && [[MIAPIDataManager sharedInstance] isReachable];
}

- (NSString *)mapperClass
{
    return nil;
}

- (void)APIActionWithRequest:(MIAPIBaseRequest *)request
                  completion:(void (^)(NSDictionary *data))completion
{
    //
}

- (void)localCacheActionWithData:(NSDictionary *)data
                      completion:(void (^)(NSArray *data))completion
{
    //
}

@end
