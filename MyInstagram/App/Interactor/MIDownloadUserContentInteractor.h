//
//  MIDownloadUserContentInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 16.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseInteractor.h"
#import "MIInstagramUser.h"

@interface MIDownloadUserContentInteractor : MIBaseInteractor

- (void)downloadContentForUser:(MIInstagramUser *)user;

@end
