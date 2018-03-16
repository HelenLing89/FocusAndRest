//
//  FocusSettingViewController.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTBaseSettingViewController.h"

@interface FocusSettingViewController : LTBaseSettingViewController

@property(nonatomic,strong) void (^timeBlock)(NSString *time);



@end
