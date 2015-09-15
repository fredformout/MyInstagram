//
//  MIPopularPhotosViewControllerInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ActivityIndicatorType)
{
    ActivityIndicatorTypeTop,
    ActivityIndicatorTypeBottom,
    ActivityIndicatorTypeAll
};

@protocol MIPhotosViewControllerInterface <NSObject>

- (void)showPosts:(NSArray *)posts;
- (void)insertElementsToBottomCount:(NSInteger)count;
- (void)reload;
- (void)stopActivityIndicator;

- (void)blockBottomRefresh;
- (void)unblockBottomRefresh;

@end
