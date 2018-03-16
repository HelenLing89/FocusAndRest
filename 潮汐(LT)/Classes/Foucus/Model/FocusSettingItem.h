//
//  FocusSettingItem.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusSettingItem : NSObject


@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* style;
@property(nonatomic,strong) UIImage* icon;
@property(nonatomic,strong) NSString* subTitle;
@property(nonatomic,strong) Class deVc;

+ (instancetype)itemWithTitle:(NSString*)title style:(NSString*)style subTitle:(NSString *)subTitle image:(UIImage *)icon ;
@end
