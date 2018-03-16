//
//  SceneItem.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/9.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "SceneItem.h"

@implementation SceneItem

+ (instancetype)itemWithSceneTitle:(NSString *)title SceneSubTitle:(NSString *)subTitle SceneImage:(UIImage *)image lockImage:(BOOL)isLocked price:(NSString *)price{
    SceneItem *item = [[SceneItem alloc] init];
    item.sceneTitle = title;
    item.subTitle = subTitle;
    item.sceneImage = image;
    item.isLocked = isLocked;
    item.price = price;
    return item;
}
@end
