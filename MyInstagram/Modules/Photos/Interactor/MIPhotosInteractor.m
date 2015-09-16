//
//  MIPhotosInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 16.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosInteractor.h"

@implementation MIPhotosInteractor

#pragma mark - MINetworkActivityInteractorInputInterface

- (BOOL)canMakeNetworkActivity
{
    return [self.dataProvider canMakeRequest];
}

@end
