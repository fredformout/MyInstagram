//
//  MIImageCacheUtility.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DownloadContentOperationPriority)
{
    DownloadContentOperationPriorityLow,
    DownloadContentOperationPriorityHigh
};

@interface MIImageCacheUtility : NSObject

+ (instancetype)sharedInstance;

- (UIImage *)imageForURLString:(NSString *)urlString;
- (void)addDownloadContentOperationWithURLString:(NSString *)urlString
                                        priority:(DownloadContentOperationPriority)priority;
- (void)cancelDownloadContentOperations;
- (void)clearCache;

@end
