//
//  MIMappingManager.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEMMapping.h"

@interface MIMappingManager : NSObject

@property (nonatomic, strong) FEMMapping *userMapping;
@property (nonatomic, strong) FEMMapping *postMapping;
@property (nonatomic, strong) FEMMapping *commentMapping;

+ (instancetype)sharedInstance;

@end
