//
//  MIPopularPhotosViewControllerInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MIPhotosViewControllerInterface <NSObject>

- (void)appendData:(NSArray *)data;
- (void)reload;

@end
