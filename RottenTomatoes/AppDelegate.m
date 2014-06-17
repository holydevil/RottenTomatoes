//
//  AppDelegate.m
//  RottenTomatoes
//
//  Created by Praveen P N on 6/5/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "BoxOfficeViewController.h"
#import "TopDvdsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Set-up view controllers for box office
    BoxOfficeViewController *boxOfficeViewController = [[BoxOfficeViewController alloc]init];
    UINavigationController *boxOfficeNavigationController = [[UINavigationController alloc] initWithRootViewController:boxOfficeViewController];
//    boxOfficeNavigationController.tabBarItem.title = @"Box Office";
//    boxOfficeNavigationController.tabBarItem.image = [UIImage imageNamed:@"add_ticket"];

    //Set-up view controllers for top DVDs
//    TopDvdsViewController *topDvdsViewController = [[TopDvdsViewController alloc]init];
//    UINavigationController *topDvdsNavigationController = [[UINavigationController alloc] initWithRootViewController:topDvdsViewController];
//    topDvdsNavigationController.tabBarItem.title = @"Top DVDs";
//    topDvdsNavigationController.tabBarItem.image = [UIImage imageNamed:@"music_record"];
    

    //Set-up tabs for the app.
//    UITabBarController *tabBarController = [[UITabBarController alloc]init];
//    [tabBarController setViewControllers:@[boxOfficeNavigationController, topDvdsNavigationController]];
    
    self.window.rootViewController = boxOfficeNavigationController;
    
    
    //Change font for Navigator bar Title
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light"  size:17.0f]}];
    //Change font for Navigator bar (back) button
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light"  size:12.0f]} forState:UIControlStateNormal];
    
//    NSArray *fonts = [UIFont fontNamesForFamilyName:@"Helvetica Neue"];
//    for(NSString *string in fonts){
//        NSLog(@"%@", string);
//    }
    
    
    
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
