//
//  SleepRespiteCenterView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/15.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "SleepRespiteCenterView.h"

@implementation SleepRespiteCenterView

+ (instancetype)sleepRespiteCenterView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
