//
//  MIDataProvider+Images.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIDataProvider.h"

@interface MIDataProvider (Images)

- (void)downloadPhotoByURLString:(NSString *)urlString
                        filename:(NSString *)filename;

@end
