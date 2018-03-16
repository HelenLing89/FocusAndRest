//
//  TimeSettingItem.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/8.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusSettingItem.h"

@interface TimeSettingItem : FocusSettingItem
@property(nonatomic,strong) void (^timeBlock)(NSString *time);
@property(nonatomic,strong) NSString *timeTitle;
@end
