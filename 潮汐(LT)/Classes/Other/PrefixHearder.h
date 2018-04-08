//
//  PrefixHearder.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#ifndef PrefixHearder_h
#define PrefixHearder_h
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#define RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBRandomColor RGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255),0.5)
#define LTkeyWindow  [UIApplication sharedApplication].keyWindow
#endif 
