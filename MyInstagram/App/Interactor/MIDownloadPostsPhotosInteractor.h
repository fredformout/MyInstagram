//
//  MIDownloadPostsPhotosInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadCommentsPhotosInteractor.h"

@interface MIDownloadPostsPhotosInteractor : MIDownloadCommentsPhotosInteractor

- (void)downloadPhotosForPosts:(NSArray *)posts;

@end
