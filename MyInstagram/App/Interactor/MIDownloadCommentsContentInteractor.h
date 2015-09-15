//
//  MIDownloadCommentsContentInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 15.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseInteractor.h"

@interface MIDownloadCommentsContentInteractor : MIBaseInteractor

- (void)downloadContentForComments:(NSArray *)comments;

@end
