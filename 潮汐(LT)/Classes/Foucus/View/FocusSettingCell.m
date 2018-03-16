//
//  FocusSettingCell.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusSettingCell.h"
#import "FocusSettingItem.h"
#import "FocusArrowItem.h"
#import "FocusSwitchItem.h"
#import "OtherItem.h"
#import "TimeSettingItem.h"

@interface FocusSettingCell()

@property (nonatomic,strong) UIImageView *arrowView;
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) UILabel *label;
@end
@implementation FocusSettingCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (UIImageView *)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_right_arrow_black_24_normal"]];
    }
    
    return _arrowView;
}

- (UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        _switchView.tintColor = [UIColor lightGrayColor];
    }

    return _switchView;
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    
    FocusSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"focus"];
    if (cell == nil) {
       cell = [[FocusSettingCell alloc] initWithStyle:style reuseIdentifier:@"focus"];
      
    }
    return cell;

}

- (void)setItem:(FocusSettingItem *)item{
    
    _item = item;
    [self setUpData];
    [self setUpAccessory];
    
}


- (void)setUpData{

  //  self.textLabel.font = [UIFont systemFontOfSize:13];
  //  self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subTitle;
   // self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
}

- (void)setUpAccessory{
    if ([_item isKindOfClass:[FocusArrowItem class]] || [_item isKindOfClass:[TimeSettingItem class]]) {
        self.accessoryView = self.arrowView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if ([_item isKindOfClass:[FocusSwitchItem class]]){
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([_item isKindOfClass:[OtherItem class]]) {
        self.textLabel.center = self.contentView.center;
    }
    
    
//    CGRect frame = self.textLabel.frame;
//    frame.origin.x = frame.origin.x + 50;
//    self.textLabel.frame = frame ;
//
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
