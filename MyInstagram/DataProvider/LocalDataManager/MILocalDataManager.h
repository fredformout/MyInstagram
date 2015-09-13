//
//  MIAppDataStore.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MILocalDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)setup;
- (void)saveData:(NSDictionary *)data
     mapperClass:(NSString *)mapperClass
      completion:(dispatch_block_t)completion;
- (NSArray *)getAllEntitiesByClass:(NSString *)className;

@end
