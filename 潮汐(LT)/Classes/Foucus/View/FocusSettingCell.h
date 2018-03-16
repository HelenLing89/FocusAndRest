//
//  FocusSettingCell.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusSettingItem ;

@interface FocusSettingCell : UITableViewCell

@property (nonatomic,strong) FocusSettingItem *item;
//@property (assign,nonatomic) UITableViewCellStyle style;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
