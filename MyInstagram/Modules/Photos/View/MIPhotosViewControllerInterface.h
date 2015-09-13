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
- (void)reload;
- (void)stopActivityIndicatorsByType:(ActivityIndicatorType)activityIndicatorType;

- (void)blockTopRefresh;
- (void)blockBottomRefresh;
- (void)unblockTopRefresh;
- (void)unblockBottomRefresh;

@end
