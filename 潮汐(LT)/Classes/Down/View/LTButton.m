//
//  LTButton.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/3.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "LTButton.h"

@implementation LTButton


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    //self.imageEdgeInsets = UIEdgeInsetsMake(50,15, 15, 15);
    //self.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 20, 10);
   // UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(8, 35, 16, 16);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(12, 5, 32, 20);
    
}
- (void)setHighlighted:(BOOL)highlighted{
    
    
}



@end
