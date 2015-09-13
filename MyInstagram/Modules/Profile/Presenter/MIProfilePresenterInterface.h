//
//  MIProfileInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MIProfilePresenterInterface <NSObject>

- (void)logoutAction;
- (void)getUser;

@end
