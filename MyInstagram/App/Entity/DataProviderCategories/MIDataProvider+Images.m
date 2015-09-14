//
//  MIDataProvider+Images.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIDataProvider+Images.h"
#import "MIFileUtility.h"

@implementation MIDataProvider (Images)

- (void)downloadPhotoByURLString:(NSString *)urlString
                        filename:(NSString *)filename
{
    if ([self canMakeRequest])
    {
        NSString *filePath = [MIFileUtility pathFromDocumentsForFilename:filename];
        
        if (![MIFileUtility fileExistsAtAbsolutePath:filePath])
        {
            if (urlString)
            {
                MIAPIRequest *request = [MIAPIRequest requestWithName:@"DownloadImage"
                                                                  url:urlString
                                                        isAbsoluteUrl:YES
                                                        requestMethod:RequestMethodGET
                                                   responseSerializer:ResponseSerializerBasic
                                                         successBlock:^(id data, id raw)
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
                    {
                        [data writeToFile:filePath
                               atomically:NO];
                        
                        dispatch_async(dispatch_get_main_queue(), ^
                        {
                            [[NSNotificationCenter defaultCenter] postNotificationName:filename
                                                                                object:nil];
                        });
                    });
                }
                                                         failureBlock:^(id error){}];
            
                [[MIAPIDataManager sharedInstance] startOperationWithRequest:request];
            }
        }
    }
}

@end
