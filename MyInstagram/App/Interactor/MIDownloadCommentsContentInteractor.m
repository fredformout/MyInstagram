//
//  MIDownloadCommentsContentInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadCommentsContentInteractor.h"
#import "MIInstagramComment.h"
#import "MIImageCacheUtility.h"

@implementation MIDownloadCommentsContentInteractor

- (void)downloadContentForComments:(NSArray *)comments
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        for (MIInstagramComment *comment in comments)
        {
            [[MIImageCacheUtility sharedInstance] addDownloadContentOperationWithURLString:comment.userPhotoURL
                                                                                  priority:DownloadContentOperationPriorityLow];
        }
    });
}

@end
