//
//  AppDelegate.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppDelegate.h"
#import "MIAppDependencies.h"
#import "MIAppDesigner.h"
#import "MIFileUtility.h"

@interface MIAppDelegate ()

@property (nonatomic, strong) MIAppDependencies *dependencies;

@end

@implementation MIAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Documents directory path: %@", [MIFileUtility pathForDocumentsDirectory]);
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _dependencies = [MIAppDependencies new];
    
    [_dependencies installAppViewControllerToWindow:_window];
    
    [MIAppDesigner setupInterface];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [_dependencies processResponseURL:url];
    
    return YES;
}

@end
