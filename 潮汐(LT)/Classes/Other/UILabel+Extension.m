//
//  UILabel+Extension.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/23.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (instancetype)labelWithText:(NSString *)text FontSize:(CGFloat)fontSize TextColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    attDic[NSStrokeColorAttributeName] = color;
    attDic[NSStrokeWidthAttributeName] = @-1;
    attDic[NSForegroundColorAttributeName] = color;
   // attDic[NSBackgroundColorAttributeName] = [UIColor clearColor];
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:text attributes:attDic];
    label.attributedText = attStr;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}


@end
