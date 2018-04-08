//
//  UIButton+Extension.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/13.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIView+LTExtension.h"

@implementation UIButton (Extension)

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color backgroudColor:(UIColor *)backgroundColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    //[button setTintColor:color];
  //  button.titleLabel.backgroundColor = color;
    [button setBackgroundColor:backgroundColor];
    return button;
}
@end
