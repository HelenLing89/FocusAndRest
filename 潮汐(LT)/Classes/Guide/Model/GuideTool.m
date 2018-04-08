//
//  GuideTool.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/23.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "GuideTool.h"
#import "DownViewController.h"
#import "GuideViewController.h"

@implementation GuideTool
+ (UIViewController *)chooseRootViewController{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
   // if ([currentVesion isEqualToString:sanboxVersion]){
    // return [[DownViewController alloc] init];
    //}else{
      //  [[NSUserDefaults standardUserDefaults] setObject:currentVesion forKey:key];
  //     [[NSUserDefaults standardUserDefaults] synchronize];
       return [[GuideViewController alloc] init];
   // }

}
@end
