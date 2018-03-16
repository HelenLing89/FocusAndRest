//
//  FocusRoundView.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/5.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusRoundView : UIView

@property (strong, nonatomic) NSString *string;
@property (strong,nonatomic) NSString *weatherStr;


+ (instancetype)focusRoundView;

- (void)starAnimatewithTime:(NSString*)time weather:(NSString *)weather;

- (void)pauseAnimate;

- (void)goOnAnimate;

- (void)stopAnimatewithTime:(NSString*)time weather:(NSString *)weather;

@end
