//
//  MIAppDesigner.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppDesigner.h"
#import "Macro.h"

static NSString *kFontName = @"MarkerFelt-Thin";

static CGFloat kNavigationBarTitleFontSize = 20.0;
static CGFloat kBarButtonTitleFontSize = 20.0;
static CGFloat kTabBarTitleFontSize = 12.0;

@implementation MIAppDesigner

+ (void)setupInterface
{
    //StatusBar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //NavigationBar
    [[UINavigationBar appearance] setBarTintColor:RGB(50.0, 106.0, 161.0)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont fontWithName:kFontName
                                                                                                 size:kNavigationBarTitleFontSize]
                                                           }];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName : [UIFont fontWithName:kFontName
                                                                                                 size:kBarButtonTitleFontSize]
                                                           }
                                                forState:UIControlStateNormal];
    
    //TabBar
    [[UITabBar appearance] setBarTintColor:RGB(37.0, 41.0, 44.0)];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName : [UIFont fontWithName:kFontName
                                                                                              size:kTabBarTitleFontSize]
                                                        }
                                             forState:UIControlStateNormal];
}

@end
