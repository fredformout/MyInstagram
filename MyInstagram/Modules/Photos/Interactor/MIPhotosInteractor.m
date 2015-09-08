//
//  MIPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosInteractor.h"

@implementation MIPhotosInteractor

#pragma mark - MIPhotosInteractorInputInterface

- (void)getPosts
{
    //getPosts
    [_presenter processPosts:@[]];
}

@end
