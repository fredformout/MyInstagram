//
//  MIPopularPhotosPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIPhotosPresenter.h"

@implementation MIPhotosPresenter

#pragma mark - MIPhotosInterface

- (void)selectPost:(NSObject *)post
{
    NSLog(@"123");
}

- (void)updateView
{
    [_interactor getPosts];
}

#pragma mark - MIPhotosInteractorOutputInterface

- (void)processPosts:(NSArray *)posts
{
    [_viewController appendData:posts];
}

@end
