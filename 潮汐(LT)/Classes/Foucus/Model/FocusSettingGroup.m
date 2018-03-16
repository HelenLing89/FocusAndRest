//
//  FocusSettingGroup.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusSettingGroup.h"

@implementation FocusSettingGroup
+(instancetype)initWithItems:(NSArray *)items{
    FocusSettingGroup *group = [[FocusSettingGroup alloc] init];
    group.items = items;
    return group;
}
@end
