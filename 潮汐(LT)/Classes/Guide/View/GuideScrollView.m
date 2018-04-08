//
//  GuideScrollView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/22.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "GuideScrollView.h"
#import "GuideItem.h"
#import "UIButton+Extension.h"
#import "UILabel+Extension.h"
#import "UIView+LTExtension.h"
#import "UpViewController.h"
#import "DownViewController.h"

@interface GuideScrollView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong,nonatomic) NSMutableArray *iconVArr;
@property (strong,nonatomic) NSMutableArray *largeLArr;
@property (strong,nonatomic) NSMutableArray *smallLArr;
@property (strong,nonatomic) NSMutableArray *buttonArr;



@end
@implementation GuideScrollView


- (NSMutableArray *)iconVArr{
    if (_iconVArr == nil) {
        _iconVArr = [NSMutableArray array];
    }
    return _iconVArr;
}

- (NSMutableArray *)largeLArr{
    if (_largeLArr == nil) {
        _largeLArr = [NSMutableArray array];
    }
    return _largeLArr;
}


- (NSMutableArray *)smallLArr{
    if (_smallLArr == nil) {
        _smallLArr = [NSMutableArray array];
    }
    return _smallLArr;
}

- (NSMutableArray *)buttonArr{
    if (_buttonArr == nil) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

+ (instancetype)guideScrollView{
    
   return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

#pragma 布局位置
- (void)layoutSubviews{
    [super layoutSubviews];
  
    self.scrollView.frame = self.bounds;
    CGFloat scrollW = self.scrollView.width;
    CGFloat scrollH = self.scrollView.height;
    CGPoint scrollCenter = self.scrollView.center;
    
    self.pageControl.size = CGSizeMake(100, 20);
    self.pageControl.center = CGPointMake(self.scrollView.centerX, scrollH*2/3);
    self.scrollView.contentSize = CGSizeMake(scrollW * self.inforArr.count, 0);
    NSLog(@"%@",self.inforArr);
    for (NSInteger index = 0; index <self.inforArr.count; index++) {
        UIImageView *image = self.iconVArr[index];
        image.center = CGPointMake((scrollCenter.x +scrollW*index), scrollH*1/3);
        UILabel *largeLabel = self.largeLArr[index];
        largeLabel.center = CGPointMake((scrollCenter.x +scrollW*index),scrollH*3/5-20);
        UILabel *smallLabel = self.smallLArr[index];
        smallLabel.center = CGPointMake((scrollCenter.x+scrollW*index), (scrollH*3/5+10));
        UIButton *button = self.buttonArr[index];
        button.size = CGSizeMake(scrollW/5, 40);
        if (index == 2) {
            button.size = CGSizeMake(screenW-80, 40);
        }
        button.center = CGPointMake((scrollCenter.x+scrollW*index),(scrollH*4/5-20));
        //NSLog(@"%@",button);
       // button.size = CGSizeMake(scrollW/5, 40);
        
        
        
    }
    
    
    
}
#pragma mark - setter方法的重写,设置对应的内容
- (void)setInforArr:(NSArray *)inforArr{
    _inforArr = inforArr;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    for (NSInteger index = 0; index < inforArr.count; index++) {
        GuideItem *item = inforArr[index];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item.icon]];
        [self.iconVArr addObject:imageV];
        [self.scrollView addSubview:imageV];
        UIButton *button = [UIButton buttonWithTitle:item.buttonWords titleColor:[UIColor whiteColor] backgroudColor:[UIColor clearColor]];
        button.tag = index;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (index == 2){
            button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [UIColor redColor].CGColor;
        }
        [self.buttonArr addObject:button];
        [self.scrollView addSubview:button];
        UILabel *largeLabel = [UILabel labelWithText:item.largeWords FontSize:20 TextColor:[UIColor whiteColor]];
        [self.largeLArr addObject:largeLabel];
        [self.scrollView addSubview:largeLabel];
        UILabel *smallLabel = [UILabel labelWithText:item.smallWords FontSize:14 TextColor:[UIColor whiteColor]];
        [self.smallLArr addObject:smallLabel];
        [self.scrollView addSubview:smallLabel];
    }
    self.pageControl.numberOfPages = inforArr.count;
}

#pragma scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = i;

}


- (void)buttonClick:(UIButton *)button{
    if (button.tag == 2) {
        LTkeyWindow.rootViewController = [[DownViewController alloc] init];;
        CATransition *amin = [CATransition animation];
        amin.duration = 1;
        amin.type = @"cude";
        [LTkeyWindow.layer addAnimation:amin forKey:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GuideViewControllerShowUpController" object:nil];
//        UpViewController *up = [[UpViewController alloc] init];
//        up.view.frame = self.bounds;
       
    }else{
     [self.scrollView setContentOffset:CGPointMake(self.scrollView.width*(button.tag+1), 0) animated:YES];
    self.pageControl.currentPage = button.tag+1;
        
  }
   
}




@end
