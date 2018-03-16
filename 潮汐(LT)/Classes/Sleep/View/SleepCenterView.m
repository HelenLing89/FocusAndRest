//
//  SleepCenterView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/15.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "SleepCenterView.h"
@interface SleepCenterView()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation SleepCenterView

//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self setRestTime:@"12:00"];
//    }
//    return self;
//
//}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setRestTime:@"12:00"];
}
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.restTime = @"12:00";
//    }
//    return self;
//
//}
+ (instancetype)sleepCenterView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    
}

- (void)setRestTime:(NSString *)restTime{
    _restTime = restTime;
    
    self.timeLabel.text = restTime;
}

- (void)layoutSubviews{
    
    
}

    
    

@end
