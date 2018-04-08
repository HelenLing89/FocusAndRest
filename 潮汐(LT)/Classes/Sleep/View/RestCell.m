//
//  RestCell.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/16.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "RestCell.h"
@interface RestCell()
@property (strong,nonatomic) UILabel *label;
@end
@implementation RestCell

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpLabel];
    }
    return self;
}

- (void)setUpLabel{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 40, 40);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    [self.contentView addSubview:label];
    
    
}

- (void)setRestT:(NSString *)restT{
    
    _restT = restT;
    
    self.label.text = restT;
    
}
@end
