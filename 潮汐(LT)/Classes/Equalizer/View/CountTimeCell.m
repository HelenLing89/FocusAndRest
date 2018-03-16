//
//  CountTimeCell.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "CountTimeCell.h"
@interface CountTimeCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
@implementation CountTimeCell

+ (instancetype)countTime{
    
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    
    self.timeLabel.text = timeStr;
    
}


- (void)awakeFromNib{
  
    
}

- (void)layoutSubviews{
    
    
    
    
}

@end
