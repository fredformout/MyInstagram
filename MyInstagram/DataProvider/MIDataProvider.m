//
//  MIDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider.h"
#import "UICKeyChainStore+SharedInstance.h"
#import "MIAPIDataManager.h"
#import "MIInstagramConstants.h"
#import "MIAPIRequest.h"

@interface MIDataProvider ()

@end

@implementation MIDataProvider

#pragma mark - Others

- (BOOL)canMakeRequest
{
    return [UICKeyChainStore sharedInstance][kAccessTokenKey]
    && [[MIAPIDataManager sharedInstance] isReachable];
}

@end
