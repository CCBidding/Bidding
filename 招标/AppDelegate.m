//
//  AppDelegate.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "TTRootViewController.h"
#import "REFrostedViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self customInterFace];
    
    if ([TTUserDefaultTool objectForKey:TTusername ]||[TTUserDefaultTool objectForKey:TTpassword]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        AFHTTPRequestOperation *op = [manager POST:TTLoginUrl
                                              parameters:@{@"username":[TTUserDefaultTool objectForKey:TTusername],@"password":[TTUserDefaultTool objectForKey:TTpassword]}
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (![responseObject[@"datas"][0][@"sessionid"]isEqualToString:@"aperror"]) {
                TTRootViewController *rootVC=[[TTRootViewController alloc]init];
<<<<<<< HEAD
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootVC];
                self.window.rootViewController=nav;
=======
                self.window.rootViewController = rootVC;
>>>>>>> 8bb36860ca65d29e942ca543b88ab5f65ad4b7f0
                
            }
            else{
                HomeViewController *home = [[HomeViewController alloc]init];
                self.window.rootViewController = home;
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
        }];
        [op start];
    }
    else{
<<<<<<< HEAD
         HomeViewController *home=[[HomeViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
       
        self.window.rootViewController=nav;
=======
        HomeViewController *home = [[HomeViewController alloc]init];
        self.window.rootViewController = home;
>>>>>>> 8bb36860ca65d29e942ca543b88ab5f65ad4b7f0
    }
   
    [self.window makeKeyAndVisible];
    return YES;
}
// 自定义界面
- (void)customInterFace{

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:229.0/255.0 green:80.0/255.0 blue:76.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:241.0/255.0 green:94.0/255.0 blue:141.0/255.0 alpha:.95]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigation"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName,[UIFont fontWithName:@"STHeitiSC-Light" size:20.0], NSFontAttributeName, nil]];

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
