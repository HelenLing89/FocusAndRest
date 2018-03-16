//
//  UIView+LTExtension.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTExtension)
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

- (BOOL)isShowingOnKeyWindow;
@end
