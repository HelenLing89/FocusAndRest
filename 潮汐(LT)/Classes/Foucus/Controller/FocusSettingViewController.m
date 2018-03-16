//
//  FocusSettingViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusSettingViewController.h"
#import "FocusSettingCell.h"
#import "FocusArrowItem.h"
#import "FocusSwitchItem.h"
#import "OtherItem.h"
#import "FocusSettingGroup.h"
#import "LTCountTimeViewController.h"
#import "LTHighEffectViewController.h"
#import "LTVoiceViewController.h"
#import "LTBaseNavigationController.h"
#import "TimeSettingItem.h"

@interface FocusSettingViewController ()


@end

@implementation FocusSettingViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
}

- (void)setUpGroup0{
    TimeSettingItem *item0 = [TimeSettingItem itemWithTitle:@"计时时长" style:@"default" subTitle:nil image:nil];
    item0.subTitle = @"20分钟";
    __weak typeof (item0)weakItem0 = item0;
    item0.timeBlock = ^(NSString *time) {
        if (time != 0)
        weakItem0.subTitle = time;
    };
    
    item0.deVc = [LTCountTimeViewController class];
    
    FocusArrowItem *item1 = [FocusArrowItem itemWithTitle:@"高效模式" style:@"default" subTitle:nil image:nil];
    item1.deVc = [LTHighEffectViewController class];
    FocusSwitchItem *item2 = [FocusSwitchItem itemWithTitle:@"沉浸模式" style:@"default" subTitle:nil image:[UIImage imageNamed:@"control_help_white_24_normal"]];
    
    FocusSettingGroup *group = [FocusSettingGroup initWithItems:@[item0,item1,item2]];
    group.headTitle = @"计时";
    [self.groups addObject:group];
}

- (void)setUpGroup1{
    FocusSwitchItem *item0 = [FocusSwitchItem itemWithTitle:@"自然声音" style:@"default" subTitle:nil image:nil];
    FocusSwitchItem *item1 = [FocusSwitchItem itemWithTitle:@"音乐融合" style:@"default" subTitle:nil image:[UIImage imageNamed:@"control_help_white_24_normal"]];
    FocusArrowItem *item2 = [FocusArrowItem itemWithTitle:@"音量" style:@"default"subTitle:nil image:nil];
    item2.deVc = [LTVoiceViewController class];
    FocusSettingGroup *group = [FocusSettingGroup initWithItems:@[item0,item1,item2]];
    group.headTitle = @"声音";
    [self.groups addObject:group];
    
}

- (void)setUpGroup2{
    FocusSwitchItem *item0 = [FocusSwitchItem itemWithTitle:@"静音通知" style:@"subTitle" subTitle:@"静音情况下仍然播放通知声音" image:nil];
    FocusSwitchItem *item1 = [FocusSwitchItem itemWithTitle:@"屏幕常亮" style:@"subTitle" subTitle:@"打开后,在专注界面内不会熄灭屏幕" image:nil];
    FocusSwitchItem *item2 = [FocusSwitchItem itemWithTitle:@"连接「健康」应用" style:@"default" subTitle:nil image:nil];
    
    OtherItem *item3 = [OtherItem itemWithTitle:nil style:nil subTitle:nil image:nil];
    OtherItem*item4 = [OtherItem itemWithTitle:@"恢复默认设置" style:nil subTitle:nil image:nil];
    item4.deVc = [UIAlertController class];
    
    FocusSettingGroup *group = [FocusSettingGroup initWithItems:@[item0,item1,item2,item3,item4]];
    group.headTitle = @"高级";
    [self.groups addObject:group];
    
}








#pragma mark - Table view data source


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
