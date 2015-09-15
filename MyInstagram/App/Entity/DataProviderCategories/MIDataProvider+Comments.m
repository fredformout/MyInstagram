//
//  MIDataProvider+Comments.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider+Comments.h"
#import "FEMDeserializer.h"

@implementation MIDataProvider (Comments)

- (void)getCommentsByPostId:(NSString *)postId
                      maxId:(NSString *)maxId
               successBlock:(void (^)(NSArray *, NSString *))successBlock
               failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [UICKeyChainStore sharedInstance][kAccessTokenKey], kAccessTokenKey,
                                           nil];
        
        if (maxId)
        {
            parameters[kMaxIdKey] = maxId;
        }
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetComments"
                                                          url:[NSString stringWithFormat:@"media/%@/comments", postId]
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                 successBlock:^(id data)
        {
            [[MIMappingManager sharedInstance] backgroundCollectionFromData:data[kDataKey]
                                                    mappingEntity:@"Comment"
                                                       completion:^(id comments)
             {
                if (successBlock)
                {
                    successBlock(comments, data[kPaginationKey][kNextMaxIdKey]);
                }
             }];
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

- (void)addCommentByPostId:(NSString *)postId
                      text:(NSString *)text
              successBlock:(void (^)(NSObject *))successBlock
              failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey],
                                     kTextKey : text
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"AddComment"
                                                          url:[NSString stringWithFormat:@"media/%@/comments", postId]
                                                requestMethod:RequestMethodPOST
                                                   paramaters:parameters
                                                 successBlock:^(id data)
        {
            if (successBlock)
            {
                successBlock(nil);
            }
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
