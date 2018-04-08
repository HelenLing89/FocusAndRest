//
//  AppDelegate.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "AppDelegate.h"
#import <UMShare/UMShare.h>
#import <Social/Social.h>
#import "UMSocialSinaHandler.h"
#import "UpViewController.h"
#import "DownViewController.h"
#import "GuideViewController.h"
#import "GuideTool.h"
#import <UserNotifications/UserNotifications.h>
#import <JPUSHService.h>
static NSString *appKey = @"b18239f494011bb6c88df98a";//（与plist文件里面的相同）
static NSString *channel = @"App Store";
@interface AppDelegate ()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
   // GuideViewController *guide = [[GuideViewController alloc] init];
    //DownViewController *down = [[DownViewController alloc] init];
    self.window.rootViewController = [GuideTool chooseRootViewController];
    [self.window makeKeyAndVisible];
    
    [self setUpUMShare];//友盟分享,需要在此处注册友盟的账号,以及分享到哪个平台的appKey
    [self setUpJpush];
    //初始化Jpush代码
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:NO];

    return YES;
}



- (void)setUpUMShare{
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5ab0a56f8f4a9d549b00001b"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"wb1920292060" appSecret:@"9e43db0242dba05aa0e57581f0b10f28" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106723039" appSecret:nil redirectURL:nil];
}

- (void)setUpJpush{
    //初始化APNs代码
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue]>= 8.0) {
        
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    NSLog(@"%d",result);
    
    return result;
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    NSLog(@"%d",result);
    
    return result;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"%s",__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
