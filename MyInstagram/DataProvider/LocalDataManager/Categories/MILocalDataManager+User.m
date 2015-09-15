//
//  MILocalDataManager+User.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager+User.h"
#import "InstagramUser.h"
#import "MagicalRecord.h"
#import "MIMappingManager.h"

@implementation MILocalDataManager (User)

- (NSObject *)user
{
    NSObject *returnValue = nil;
    
    NSArray *users = [InstagramUser MR_findAll];
    
    if (users
        && [users count] > 0)
    {
        InstagramUser *user = [users firstObject];
        
        NSDictionary *data = [[MIMappingManager sharedInstance] dataFromManagedObject:user
                                                                        mappingEntity:@"User"];
        returnValue = [[MIMappingManager sharedInstance] objectFromData:data
                                                          mappingEntity:@"User"];
    }
    
    return returnValue;
}

- (void)saveUserFromData:(NSDictionary *)data
              completion:(dispatch_block_t)completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
     {
         [[MIMappingManager sharedInstance] managedObjectFromData:data
                                                    mappingEntity:@"User"
                                                          context:localContext];
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
