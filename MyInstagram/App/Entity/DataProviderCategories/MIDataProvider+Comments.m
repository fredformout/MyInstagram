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
        lastViewedCommentId:(NSString *)lastViewedCommentId
               successBlock:(void (^)(NSArray *))successBlock
               failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        NSDictionary *parameters = @{
                                     kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                     };
        
        MIAPIRequest *request = [MIAPIRequest requestWithName:@"GetComments"
                                                          url:[NSString stringWithFormat:@"media/%@/comments", postId]
                                                requestMethod:RequestMethodGET
                                                   paramaters:parameters
                                                mappingEntity:@"Comment"
                                                   mappingKey:kDataKey
                                                  mappingType:MappingTypeCollection
                                                 successBlock:^(id data, id raw)
        {
            if (successBlock)
            {
                successBlock(data);
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
                                                 successBlock:^(id data, id raw)
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
