//
//  SceneCell.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/9.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SceneItem;

@interface SceneCell : UITableViewCell

@property(nonatomic,strong)SceneItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
