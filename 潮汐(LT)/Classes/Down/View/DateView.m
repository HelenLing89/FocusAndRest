//
//  DateView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "DateView.h"


#import "LTCollectionViewCell.h"
#import "LinerLayout.h"
@interface DateView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *dateCollectionView;


@end


@implementation DateView

+ (instancetype)dateView{
    
  return  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DateView class]) owner:nil options:nil].lastObject;
    
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
   // [self setUpCollectionView];
    
   // DateCollectionView *collection = [DateCollectionView dateCollectionView];
    
   // [self addSubview:collection];
    

    
}


- (void)setUpCollectionView{
    
    CGFloat x = 0;
    CGFloat y = self.frame.size.height * 0.5;
    CGFloat w = self.frame.size.width;
    CGFloat h = y;
    
   // LinerLayout *layout = [[LinerLayout alloc] init];
    //.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumLineSpacing = 2;
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(x,y,w, h) collectionViewLayout:layout];
    view.userInteractionEnabled = YES;
    view.alwaysBounceHorizontal=YES;
    view.scrollsToTop = NO;
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.scrollEnabled = YES;
    
    
   
    self.dateCollectionView = view;
    [self addSubview:view];
    //self.dateCollectionView.collectionViewLayout = [[LinerLayout alloc] init];
    
    self.dateCollectionView.delegate = self;
    self.dateCollectionView.dataSource = self;
    
    [self.dateCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LTCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"date"];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 200;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"date" forIndexPath:indexPath];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.item);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
