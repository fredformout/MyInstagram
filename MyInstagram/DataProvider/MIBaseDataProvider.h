//
//  MIDataProvider.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIAPIBaseRequest.h"
#import "MIAPIDataManager.h"
#import "MILocalDataManager.h"
#import "MIMappingManager.h"
#import "UICKeyChainStore+SharedInstance.h"
#import "MIInstagramConstants.h"

@interface MIBaseDataProvider : NSObject

+ (BOOL)canMakeRequest;
- (NSString *)mapperClass;

@end
