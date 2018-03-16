//
//  FocusCenterView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/6.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusCenterView.h"

@implementation FocusCenterView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        
        // 把当前控件上的坐标系转换成子控件上的坐标系
        CGPoint childP = [self convertPoint:point toView:childView];
        
        UIView *fitView = [childView hitTest:childP withEvent:event];
        
        
        if (fitView) { // 寻找到最合适的view
            return fitView;
        }
        
    }
        
        return nil;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
