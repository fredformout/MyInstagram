//
//  MIDownloadCommentsPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadCommentsPhotosInteractor.h"
#import "MIDataProvider+Images.h"
#import "MIInstagramComment.h"

@implementation MIDownloadCommentsPhotosInteractor

- (void)downloadPhotosForComments:(NSArray *)comments
{
    for (MIInstagramComment *comment in comments)
    {
        [self.dataProvider downloadPhotoByURLString:comment.userPhotoURL
                                           filename:[NSString stringWithFormat:@"%@_%@", kUserPhotoPattern, comment.identifier]];
    }
}

@end
