//
//  UIPickerView+Extension.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/15.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "UIPickerView+Extension.h"

@implementation UIPickerView (Extension)
- (void)deleteSeperator:(UIView *)view{
    if (view.subviews != 0) {
        if (view.bounds.size.height < 5) {
            view.backgroundColor = [UIColor clearColor];
        }
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self deleteSeperator:obj];
        }];
    }
}


@end
