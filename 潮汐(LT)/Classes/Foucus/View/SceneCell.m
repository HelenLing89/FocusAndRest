//
//  SceneCell.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/9.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "SceneCell.h"
#import "SceneItem.h"

@interface SceneCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *sceneLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneSubLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lockImage;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation SceneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.borderWidth = 2;
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(2, 2);
    // Initialization code
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    SceneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scene"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SceneCell class]) owner:nil options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    

}




- (void)setItem:(SceneItem *)item{
    _item = item;
    self.sceneLabel.text = item.sceneTitle;
    self.sceneSubLabel.text = item.subTitle;
    self.iconView.image = item.sceneImage;
    self.lockImage.hidden = item.isLocked;
    self.priceBtn.hidden = item.isLocked;
    [self.priceBtn setTitle:item.price forState:UIControlStateNormal];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
