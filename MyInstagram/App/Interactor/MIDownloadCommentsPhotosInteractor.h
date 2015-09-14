//
//  MIDownloadCommentsPhotosInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseInteractor.h"

@interface MIDownloadCommentsPhotosInteractor : MIBaseInteractor

- (void)downloadPhotosForComments:(NSArray *)comments;

@end
