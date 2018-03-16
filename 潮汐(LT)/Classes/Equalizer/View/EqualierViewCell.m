//
//  EqualierViewCell.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/7.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "EqualierViewCell.h"
#import "EqualierViewController.h"
#import "CountTimeCell.h"

@interface EqualierViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIButton *openBtn;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) EqualierViewController *vc;



@end
@implementation EqualierViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.openBtn.selected = YES;
    self.closeBtn.selected = !self.openBtn.selected;
    //[self setUpCollectionView];
    
}

- (void)layoutSubviews{
    //self.frame = CGRectMake(0, 0, screenW-40, 44);
    //self.separatorInset = UIEdgeInsetsMake(40, 15, 0, 15);
    
}



- (void)setUpCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(30,30);
    layout.minimumLineSpacing = 30;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20,60, screenW, 44) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.alwaysBounceHorizontal=YES;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = YES;
    collectionView.backgroundColor = [UIColor grayColor];
    EqualierViewController *vc = [[EqualierViewController alloc] init];
    self.vc = vc;
    collectionView.delegate = vc;
    collectionView.dataSource = vc;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CountTimeCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.contentView.backgroundColor = [UIColor redColor];
    [self addSubview:self.collectionView];
    
    
}

- (IBAction)openBtnClick:(UIButton *)sender {
    
    sender.selected = self.closeBtn.selected;
    self.closeBtn.selected = !self.closeBtn.selected;
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    
    sender.selected = self.openBtn.selected;
    self.openBtn.selected = !self.openBtn.selected;
    
}


- (void)setVoiceStr:(NSString *)voiceStr{
    _voiceStr = voiceStr;
    self.voiceLabel.text = voiceStr;
    
    
}
- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    
    if (timeStr == nil) {
        self.openBtn.hidden = NO;
        self.closeBtn.hidden = NO;
        self.openBtn.selected = YES;
        self.closeBtn.selected = !self.openBtn.selected;
        self.timeL.hidden = YES;
        
    }else{
        self.openBtn.hidden = YES;
        self.closeBtn.hidden = YES;
        self.timeL.text = [NSString stringWithFormat:@"%@分钟",timeStr];
       // self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    
}


- (void)setSelected:(BOOL)selected{
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
    self.collectionView.backgroundColor = [UIColor redColor];
    
    
}

@end
