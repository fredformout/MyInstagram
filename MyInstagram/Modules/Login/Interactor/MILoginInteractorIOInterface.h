//
//  MILoginInteractorIOInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MILoginInteractorInputInterface <NSObject>

- (void)checkAPIRequestsAvailability;
- (void)getLoginURLRequest;
- (void)processResponseWithURL:(NSURL *)url;

@end

@protocol MILoginInteractorOutputInterface <NSObject>

- (void)loginInstagram;
- (void)processLoginURLRequest:(NSURLRequest *)urlRequest;
- (void)finishLoginWithSuccess:(BOOL)success;

@end
