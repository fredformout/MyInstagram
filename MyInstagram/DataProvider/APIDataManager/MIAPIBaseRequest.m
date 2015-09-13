//
//  MIAPIBaseRequest.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAPIBaseRequest.h"
#import "MIInstagramConstants.h"

@implementation MIAPIBaseRequest

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.baseUrl = kInstagramBaseURL;
        self.isAbsoluteURL = NO;
        self.responseSerializer = ResponseSerializerJSON;
        self.parameters = [NSMutableDictionary dictionary];
    }
    
    return self;
}

@end
