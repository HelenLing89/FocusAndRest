//
//  LTCollectionViewCell.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "LTCollectionViewCell.h"
#import "LTButton.h"

@interface LTCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
//@property (weak, nonatomic) IBOutlet LTButton *button;
@end

@implementation LTCollectionViewCell




- (void)setDate:(NSString *)date{
    _date = date;
    [self.button setTitle:date forState:UIControlStateNormal];
    [self.button setTitle:@"2" forState:UIControlStateSelected];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
   
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.imageV.layer.masksToBounds = YES;
    self.imageV.userInteractionEnabled = NO;
    [self.button setImage:[UIImage imageNamed:@"generate_tab_selected"] forState:UIControlStateSelected];
    //self.button.imageView.image = YES;
    self.button.tag = self.tag;
    self.button.userInteractionEnabled = NO;
   // [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self.button setTitle:@"2" forState:UIControlStateNormal];
    //[self.button setTitle:@"2" forState:UIControlStateSelected];
}

//- (void)setSelected:(BOOL)selected{
//    
//    self.button.selected = selected;
//    
//    
//}


//- (IBAction)buttonClick:(LTButton *)sender {
//    
//    sender.selected = !sender.selected;
//}




//- (void)buttonClick:(LTButton*)button{
    
  //   button.selected = YES;
 //}



    

    




@end
