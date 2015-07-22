//
//  AppDelegate.m
//  招标
//
//  Created by mac chen on 15/7/2.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "HomeViewController.h"
#import "TTRootViewController.h"
#import "REFrostedViewController.h"

@interface AppDelegate ()
{
    NSMutableArray *dataSource; //用来存信息的数据
    NSDictionary *tappedDic;    //点击顶部的通知栏的字典

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self jPushRegist:launchOptions];
    
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


#pragma mark - 注册极光推送
- (void)jPushRegist:(NSDictionary *)launchOptions
{
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
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

//极光推送的代码
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"%@",userInfo);
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//保存请求时间
- (void)saveterminateRequestTime
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    [TTUserDefaultTool setObject:[NSString stringWithFormat:@"%.0f",interval] forKey:TTEnterBackOrTerminateTime];
 
}

//获取中间的消息
- (void)requestMyNotifications
{
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     [self saveterminateRequestTime];
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
     [self requestMyNotifications];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
      [self saveterminateRequestTime];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
