//
//  CircleAnimationView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/14.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "CircleAnimationView.h"

@implementation CircleAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}


- (void)drawRect:(CGRect)rect {
    NSInteger count = 4;
    NSInteger animationDuration = 6;
    for (int i = 0; i < count; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = rect;
        layer.borderColor = [UIColor grayColor].CGColor;
        layer.cornerRadius = rect.size.width/2;
        layer.borderWidth = 2;
        layer.masksToBounds = YES;
        CAAnimationGroup *group = [CAAnimationGroup animation];
        CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        group.timingFunction = function;
        group.beginTime = CACurrentMediaTime() + i;
        group.duration = animationDuration;
        group.repeatCount = MAXFLOAT;
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        basic.fromValue = @1.0;
        basic.toValue = @1.15;
        
        CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacity.values = @[@0.1,@0.2,@0.3,@0.2,@0.1];
        
        group.animations = @[basic,opacity];
        [layer addAnimation:group forKey:@"circle"];
        [self.layer addSublayer:layer];
        
    }
}


@end
