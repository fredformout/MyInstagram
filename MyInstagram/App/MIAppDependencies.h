//
//  MIAppDependencies.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIAppDependencies : NSObject

- (void)processResponseURL:(NSURL *)url;
- (void)installAppViewControllerToWindow:(UIWindow *)window;

@end
