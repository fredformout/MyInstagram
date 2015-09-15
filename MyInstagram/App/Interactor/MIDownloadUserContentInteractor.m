//
//  MIDownloadUserContentInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 16.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadUserContentInteractor.h"
#import "MIImageCacheUtility.h"

@implementation MIDownloadUserContentInteractor

- (void)downloadContentForUser:(MIInstagramUser *)user
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:user.userPhotoURL
                                                                              priority:DownloadContentOperationPriorityHigh];
    });
}

@end
