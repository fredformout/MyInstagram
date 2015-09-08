//
//  MILoginPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILoginPresenter.h"
#import "InstagramKit.h"

@implementation MILoginPresenter

#pragma mark - MILoginInterface

- (void)loginAction
{
//    [[InstagramEngine sharedEngine] logout];
    
    InstagramKitLoginScope scope = InstagramKitLoginScopeBasic | InstagramKitLoginScopeComments | InstagramKitLoginScopeLikes;
    
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizarionURLForScope:scope];
    [[UIApplication sharedApplication] openURL:authURL];
    
//    [[] loadRequest:[NSURLRequest requestWithURL:authURL]];
    
    
//    InstagramEngine *engine = [InstagramEngine sharedEngine];
//    [engine getPopularMediaWithSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
//        // media is an array of InstagramMedia objects
//        NSLog(@"media %@", media);
//    } failure:^(NSError *error, NSInteger statusCode) {
//        
//    }];
}

@end
