//
//  MIPhotosInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MIPhotosInterface <NSObject>

- (void)selectPost:(NSObject *)post;
- (void)updateView;

@end
