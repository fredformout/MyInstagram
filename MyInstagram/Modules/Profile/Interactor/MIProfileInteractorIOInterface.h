//
//  MIProfileInteractorIOInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIInstagramUser.h"

@protocol MIProfileInteractorInputInterface <NSObject>

- (void)getLocalUser;
- (void)getUser;
- (void)logout;

@end

@protocol MIProfileInteractorOutputInterface <NSObject>

- (void)showUser:(MIInstagramUser *)user;
- (void)showLoginInterface;

@end
