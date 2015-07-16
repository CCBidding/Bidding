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
    // 友盟统计
//    [MobClick startWithAppkey:@"55a6132567e58e74bc005e00" reportPolicy:BATCH   channelId:@"Web"];
//    [MobClick setEncryptEnabled:YES];//对数据的加密，默认情况下不加密
//    [MobClick setBackgroundTaskEnabled:YES]; // 开启后台模式，保存数据的持久化操作，保证数据的完整性
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    
//    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    if ([TTUserDefaultTool objectForKey:TTusername ]&&[TTUserDefaultTool objectForKey:TTpassword]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString *username = [[TTUserDefaultTool objectForKey:TTusername]isKindOfClass:[NSNull class]]?@"":[TTUserDefaultTool objectForKey:TTusername];
        NSString *password = [[TTUserDefaultTool objectForKey:TTpassword]isKindOfClass:[NSNull class]]?@"":[TTUserDefaultTool objectForKey:TTpassword];
        AFHTTPRequestOperation *op = [manager POST:TTLoginUrl
                                              parameters:@{@"username":username,@"password":password}
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (![responseObject[@"datas"][0][@"sessionid"]isEqualToString:@"aperror"]) {
                TTRootViewController *rootVC=[[TTRootViewController alloc]init];

                self.window.rootViewController = rootVC;

                
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

        

        HomeViewController *home = [[HomeViewController alloc]init];
        self.window.rootViewController = home;

    }
   
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)getCategory{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer             = [AFJSONResponseSerializer serializer];
    AFHTTPRequestOperation *op             = [manager POST:TTgetCategorylistUrl
                                    parameters:@{}
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSMutableArray *arr=[NSMutableArray arrayWithCapacity:10];
                                        for (NSDictionary *dic in responseObject[@"datas"]) {
                                            [arr addObject:dic[@"bid_name"]];
                                        }
                                           [TTUserDefaultTool setObject:arr forKey:TTcateGory];
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           NSLog(@"%@",error);
                                       }];
    [op start];


}
// 自定义界面
- (void)customInterFace{

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:241.0/255.0 green:94.0/255.0 blue:141.0/255.0 alpha:.95]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigation"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[colorTurn colorTurnWithRed:155 greed:36 blue:32 alpa:1], NSForegroundColorAttributeName,[UIFont fontWithName:@"STHeitiSC-Light" size:20.0], NSFontAttributeName, nil]];

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
