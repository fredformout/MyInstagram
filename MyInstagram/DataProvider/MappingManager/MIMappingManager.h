//
//  MIMappingManager.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEMMapping.h"

typedef void (^MappingCompletionBlock)(id data);

@interface MIMappingManager : NSObject

+ (instancetype)sharedInstance;

- (id)objectFromData:(id)data
       mappingEntity:(NSString *)mappingEntity;
- (id)collectionFromData:(id)data
           mappingEntity:(NSString *)mappingEntity;

- (void)backgroundObjectFromData:(id)data
                   mappingEntity:(NSString *)mappingEntity
                      completion:(MappingCompletionBlock)completion;
- (void)backgroundCollectionFromData:(id)data
                       mappingEntity:(NSString *)mappingEntity
                          completion:(MappingCompletionBlock)completion;

- (id)managedObjectFromData:(id)data
              mappingEntity:(NSString *)mappingEntity
                    context:(id)context;
- (id)managedObjectsCollectionFromData:(id)data
                         mappingEntity:(NSString *)mappingEntity
                               context:(id)context;

- (id)dataFromObject:(id)object
       mappingEntity:(NSString *)mappingEntity;
- (id)dataFromCollection:(id)collection
           mappingEntity:(NSString *)mappingEntity;

- (id)dataFromManagedObject:(id)object
              mappingEntity:(NSString *)mappingEntity;
- (id)dataFromManagedObjectsCollection:(id)collection
                         mappingEntity:(NSString *)mappingEntity;

@end
