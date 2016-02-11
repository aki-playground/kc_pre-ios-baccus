//
//  AppDelegate.m
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AppDelegate.h"
#import "AOAWineModel.h"
#import "AOAWineryModel.h"
#import "AOAWineViewController.h"
#import "AOAWineryTableViewController.h"

#import "AOAWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)            application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Creamos los modelos
    AOAWineryModel *winery = [[AOAWineryModel alloc] init];

    //Creamos la table view
    AOAWineryTableViewController *wineryVC = [[AOAWineryTableViewController alloc] initWithModel: winery
                                                                                           style: UITableViewStylePlain];
    AOAWineViewController *wineVC = [[AOAWineViewController alloc]initWithModel:[wineryVC lastSelectedWine]];
    
    //Cramos el navigation
    UINavigationController * wineryNavVC = [[UINavigationController alloc] initWithRootViewController: wineryVC];
    UINavigationController * wineNavVC = [[UINavigationController alloc] initWithRootViewController: wineVC];
    
    //El combinador split view
    UISplitViewController * splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNavVC, wineNavVC];
    
    //Asignar delegados
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor orangeColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = splitVC;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
