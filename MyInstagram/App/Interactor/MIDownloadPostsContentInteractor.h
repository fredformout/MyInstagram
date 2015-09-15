//
//  MIDownloadPostsContentInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDownloadCommentsContentInteractor.h"

@interface MIDownloadPostsContentInteractor : MIDownloadCommentsContentInteractor

- (void)downloadContentForPosts:(NSArray *)posts;

@end
