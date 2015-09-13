//
//  MICommentsDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsDataProvider.h"
#import "FEMDeserializer.h"

@implementation MICommentsDataProvider

+ (void)getCommentsByPostId:(NSString *)postId
        lastViewedCommentId:(NSString *)lastViewedCommentId
               successBlock:(void (^)(NSArray *))successBlock
               failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"GetComments";
        request.url = [NSString stringWithFormat:@"media/%@/comments", postId];
        [request.parameters addEntriesFromDictionary:@{
                                                       kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]
                                                       }];
        request.requestMethod = RequestMethodGET;
        
        request.successBlock = ^(NSDictionary *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
           {
               FEMDeserializer *deserializer = [[FEMDeserializer alloc] init];
               NSArray *comments = [deserializer collectionFromRepresentation:data[kDataKey]
                                                                      mapping:[MIMappingManager sharedInstance].commentMapping];
               
               dispatch_async(dispatch_get_main_queue(), ^
               {
                   if (successBlock)
                   {
                       successBlock(comments);
                   }
               });
           });
        };
        
        request.failureBlock = ^(id error)
        {
            NSLog(@"Error: %@", [error description]);
        };
        
        [[MIAPIDataManager sharedInstance] startRequest:request];
    }
    else
    {
        //get data from local cache
        //successBlock();
    }
}

+ (void)addCommentByPostId:(NSString *)postId
                      text:(NSString *)text
              successBlock:(void (^)(NSObject *))successBlock
              failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"AddComment";
        request.url = [NSString stringWithFormat:@"media/%@/comments", postId];
        [request.parameters addEntriesFromDictionary:@{
                                                       kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey],
                                                       kTextKey : text
                                                       }];
        request.requestMethod = RequestMethodPOST;
        
        request.successBlock = ^(NSDictionary *data)
        {
            if (successBlock)
            {
                successBlock(nil);
            }
        };
        
        request.failureBlock = ^(id error)
        {
            NSLog(@"Error: %@", [error description]);
        };
        
        [[MIAPIDataManager sharedInstance] startRequest:request];
    }
    else
    {
        //get data from local cache
        //successBlock();
    }
}

@end
