//
//  AppDelegate.m
//  test1
//
//  Created by yangshuo on 14-5-3.
//  Copyright (c) 2014年 yangshuo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MyBundleDetailViewController.h"
//#import <JSPatch/JSPatch.h>
#import "IndexVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    IndexVC *mvc = [[MyBundleDetailViewController alloc]init];
    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:mvc];
    self.window.rootViewController =nav;
    
//    [JSPatch startWithAppKey:@"64d67fd83adf60e8"];
//    [JSPatch sync];
//    [JSPatch setLogger:^(NSString *msg) {
//        //msg 是 JSPatch log 字符串，用你自定义的logger打出
//        YOUR_APP_LOG(@"%@", msg);
//    }];
//    NSInteger today = -2;
//    NSString *todayStr = [arrayProgress[i] stringValue];
//    NSInteger todayOo = labs(today);
//    NSLog(@"-----%ld",todayOo);
    
    NSInteger cellNum = 5;
    NSInteger wordCount = 2000;
    NSMutableSet *idstrings = [[NSMutableSet alloc] init];
    while (idstrings.count < cellNum)
    {
        NSInteger randomInt = arc4random() % wordCount;
        [idstrings addObject:@(randomInt)];
    }
    NSArray *returnArray = [idstrings allObjects];
    
    NSString *idString = [returnArray componentsJoinedByString:@","];
    NSLog(@"----%@------%@",idstrings),returnArray;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
