//
//  MIPhotosDataProvider.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIMediaDataProvider.h"
#import "FEMDeserializer.h"
#import "MIMappingManager.h"
#import "NSData+SaveData.h"

@implementation MIMediaDataProvider

#pragma mark - Others

+ (void)getPopularPostsWithSuccessBlock:(void (^)(NSArray *data))successBlock
                           failureBlock:(void (^)(NSString *error))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"GetPopularPosts";
        request.url = @"media/popular";
        [request.parameters addEntriesFromDictionary:@{kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]}];
        request.requestMethod = RequestMethodGET;
        
        request.successBlock = ^(NSDictionary *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
            {
                FEMDeserializer *deserializer = [[FEMDeserializer alloc] init];
                NSArray *posts =  [deserializer collectionFromRepresentation:data[kDataKey]
                                                   mapping:[MIMappingManager sharedInstance].postMapping];
                
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if (successBlock)
                    {
                        successBlock(posts);
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
        successBlock([NSArray array]);
    }
}

+ (void)getPostById:(NSString *)postId
       successBlock:(void (^)(NSObject *))successBlock
       failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"GetPost";
        request.url = [NSString stringWithFormat:@"media/%@", postId];
        [request.parameters addEntriesFromDictionary:@{kAccessTokenKey : [UICKeyChainStore sharedInstance][kAccessTokenKey]}];
        request.requestMethod = RequestMethodGET;
        
        request.successBlock = ^(NSDictionary *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
            {
                FEMDeserializer *deserializer = [[FEMDeserializer alloc] init];
                NSObject *post =  [deserializer objectFromRepresentation:data[kDataKey]
                                                                 mapping:[MIMappingManager sharedInstance].postMapping];
               
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if (successBlock)
                    {
                        successBlock(post);
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

+ (void)getPhotoByURLString:(NSString *)URLString
                 identifier:(NSString *)identifier
               successBlock:(void (^)(NSString *))successBlock
               failureBlock:(void (^)(NSString *))failureBlock
{
    if ([self canMakeRequest])
    {
        MIAPIBaseRequest *request = [MIAPIBaseRequest new];
        request.name = @"GetPhoto";
        request.url = URLString;
        request.isAbsoluteURL = YES;
        request.requestMethod = RequestMethodGET;
        request.responseSerializer = ResponseSerializerBasic;
        
        request.successBlock = ^(NSData *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
            {
                NSString *filename = [NSString stringWithFormat:@"photo_%@.png", identifier];
                
                [data saveDataInDocumentDirectoryPath:filename];
                
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if (successBlock)
                    {
                        successBlock(filename);
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

@end
