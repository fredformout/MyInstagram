//
//  AppDelegate.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppDelegate.h"
#import "MIAppDependencies.h"

@interface MIAppDelegate ()

@property (nonatomic, strong) MIAppDependencies *dependencies;

@end

@implementation MIAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _dependencies = [MIAppDependencies new];
    
    [_dependencies installAppViewControllerIntoWindow:_window];
    [_dependencies setupColorScheme];
    
    return YES;
}

@end
