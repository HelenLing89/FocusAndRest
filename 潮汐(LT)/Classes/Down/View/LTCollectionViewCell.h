//
//  LTCollectionViewCell.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTButton;

@interface LTCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) NSString *date;
@property (assign,nonatomic) NSInteger selTag;
@property (weak, nonatomic) IBOutlet LTButton *button;








@end
