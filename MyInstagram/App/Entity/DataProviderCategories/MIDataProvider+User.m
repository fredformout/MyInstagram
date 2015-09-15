//
//  MIDataProvider+User.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider+User.h"
#import "MILocalDataManager+User.h"

@implementation MIDataProvider (User)

- (NSObject *)localUser
{
    return [[MILocalDataManager sharedInstance] user];
}

- (void)getUserInfoWithSuccessBlock:(void (^)(NSObject *data))successBlock
                       failureBlock:(void (^)(NSString *error))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetUserInfo"
                                                          url:@"users/self"
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                 successBlock:^(id data)
        {
            [[MIMappingManager sharedInstance] backgroundObjectFromData:data[kDataKey]
                                                mappingEntity:@"User"
                                                   completion:^(id data)
            {
                if (successBlock)
                {
                    successBlock(data);
                }
            }];
            

            [[MILocalDataManager sharedInstance] saveUserFromData:data[kDataKey]
                                                       completion:nil];
        }
                                                 failureBlock:^(id error)
        {
            NSLog(@"Error: %@", [error description]);
            
            if (failureBlock)
            {
                failureBlock(error);
            }
        }];
        
        [[MIAPIDataManager sharedInstance] startOperationWithRequest:request];
    }
    else
    {
        if (failureBlock)
        {
            failureBlock(@"Network is not available.");
        }
    }
}

@end
