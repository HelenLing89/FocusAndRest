//
//  FocusSettingItem.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusSettingItem.h"

@implementation FocusSettingItem

+ (instancetype)itemWithTitle:(NSString*)title style:(NSString*)style subTitle:(NSString *)subTitle image:(UIImage *)icon{
    FocusSettingItem *item = [[self alloc] init];
    item.title = title;
    item.style = style;
    item.icon = icon;
    item.subTitle = subTitle;
    
    return item;
}



@end
