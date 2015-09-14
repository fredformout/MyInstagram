//
//  MILocalDataManager+User.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager+User.h"
#import "FEMSerializer.h"
#import "FEMDeserializer.h"
#import "InstagramUser.h"
#import "MagicalRecord.h"
#import "MIMappingManager.h"
#import "MIConstants.h"

@implementation MILocalDataManager (User)

- (NSObject *)user
{
    NSObject *returnValue = nil;
    
    NSArray *users = [InstagramUser MR_findAll];
    
    if (users
        && [users count] > 0)
    {
        InstagramUser *user = [users firstObject];
        
        NSDictionary *data = [FEMSerializer serializeObject:user
                                               usingMapping:[[MIMappingManager sharedInstance] mappingForKey:kUserManagedObjectMappingKey]];
        FEMDeserializer *deserializer = [[FEMDeserializer alloc] init];
        returnValue = [deserializer objectFromRepresentation:data
                                                     mapping:[[MIMappingManager sharedInstance] mappingForKey:kUserObjectMappingKey]];
    }
    
    return returnValue;
}

- (void)saveUserFromData:(NSDictionary *)data
              completion:(dispatch_block_t)completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
     {
         FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithContext:localContext];
         [deserializer objectFromRepresentation:data
                                        mapping:[[MIMappingManager sharedInstance] mappingForKey:kUserManagedObjectMappingKey]];
     }
                      completion:^(BOOL contextDidSave, NSError *error)
     {
         if (completion)
         {
             completion();
         }
     }];
}

@end
