//
//  GuideItem.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/23.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "GuideItem.h"

@implementation GuideItem
+ (instancetype)guideItemWithDict:(NSDictionary *)dict{
    
    GuideItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
