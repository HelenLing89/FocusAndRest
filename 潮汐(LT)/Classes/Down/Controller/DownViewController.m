//
//  DownViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "DownViewController.h"
#import "LTCollectionViewCell.h"
#import "LTButton.h"
#import "CenterView.h"
#import "UpViewController.h"
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
@interface DownViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak,nonatomic) LTCollectionViewCell *selCell;

@property (assign,nonatomic) NSInteger lastIndexPath;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopCons;



@property (weak, nonatomic) CenterView *centerView;

@end

@implementation DownViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self setUpScrollView];
  //  [self setUpCollectionView];
    [self setUpCenterView];
    [self setUpDateView];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
   
    
    
}

- (void)setUpDateView{
//    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    CGFloat x = 0;
    CGFloat y = self.dateView.frame.size.height - 80;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = y;
    
   // UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, -150, self.view.frame.size.width, 150)];
    //dateView.backgroundColor = [UIColor redColor];
    
    
    // LinerLayout *layout = [[LinerLayout alloc] init];
    //.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.itemSize = CGSizeMake(32, 80);
    layout.minimumLineSpacing = 23;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x,y,w,80) collectionViewLayout:layout];
    collectionView.userInteractionEnabled = YES;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = YES;
    self.collectionView = collectionView;
    
    [self.dateView addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LTCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"date"];
    
    
  //  [collectionView selectItemAtIndexPath:[NSIndexPath indexPathWithIndex:200] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
  // [self collectionView:collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathWithIndex:4]];
    
    //NSIndexPath *indexPath = [NSIndexPath indexPathForItem:10 inSection:1];
     //[collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
   // [self ]
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"date" forIndexPath:indexPath];
    
    cell.date = @"3";
    cell.tag = indexPath.item;
    
    
    return cell;
}

- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated{
    
    //LTCollectionViewCell  *cell = (LTCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //cell.button.
    
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    
}


- (void)buttonClickWithButton:(LTButton*)button selectedButton:(LTButton *)selectedButton {
    button.selected = YES;
    selectedButton.selected = NO;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LTCollectionViewCell  *cell = (LTCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    if (_selCell != cell) {
        cell.button.selected = YES;
        _selCell.button.selected = NO;
        _selCell = cell;
    }
    
    NSLog(@"%ld----cell",indexPath.item);
    CGPoint offSet = CGPointMake(indexPath.item * self.view.bounds.size.width, 0);
    [self.scrollView setContentOffset:offSet animated:YES];
    
}






- (void)setUpScrollView{
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.pagingEnabled = YES;
    
    for (int i = 0; i< 4; i++){
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*screenW, 0, screenW-2, screenH)];
        imageV.image = image;
        imageV.userInteractionEnabled = YES;
       // imageV.frame = CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width-2, self.view.bounds.size.height);
        [self.scrollView addSubview:imageV];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 4, 0);
   // self.scrollView = scrollView;
    self.scrollView.delegate = self;

   // [self.view insertSubview:scrollView belowSubview:self.dateView];
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upCalender)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.scrollView addGestureRecognizer:up];
    
    
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(calendarBtnClick)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.scrollView addGestureRecognizer:down];
   
    

}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x / self.view.bounds.size.width;
 //   NSLog(@"%f,%f",scrollView.contentOffset.x ,scrollView.bounds.size.width);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    NSLog(@"%ld",i);
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
    
    
}


- (void)setUpCenterView{
    
    CenterView *centerView = [CenterView centerView];
    self.centerView = centerView;
    centerView.userInteractionEnabled = YES;
    UIBarButtonItem *calendarBtn = [centerView.calendarBtn initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(calendarBtnClick)];
    UIBarButtonItem *closeBtn = [centerView.closeBtn initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(closeBtnClick:)];
    UIBarButtonItem *relinkBtn = [centerView.relinkBtn initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(relinkBtnClick:)];
  // centerView.userInteractionEnabled = NO;
   [self.view insertSubview:centerView aboveSubview:self.scrollView];
    
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(presentUpController)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.centerView addGestureRecognizer:up];
    
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(calendarBtnClick)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.centerView addGestureRecognizer:down];
    
    
}


- (void)presentUpController{
    
    UpViewController *upVc = [[UpViewController alloc] init];
    [self presentViewController:upVc animated:YES completion:nil];
    
    
}

- (void)upCalender{
    

    [UIView animateWithDuration:0.5 animations:^{
        
        self.centerView.userInteractionEnabled = YES;
        
        self.scrollViewTopCons.constant = 0;
        self.dateViewTopCons.constant = -150;
        
        
    }];
    
}

- (void)calendarBtnClick{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.centerView.userInteractionEnabled = NO;
        
     //   [self.view insertSubview:self.dateView aboveSubview:self.centerView];
        self.scrollViewTopCons.constant = 150;
        self.dateViewTopCons.constant = 0;
        
        
    }];
    
    
}


- (void)closeBtnClick:(UIBarButtonItem *)btn{
    

    
    
}

- (void)relinkBtnClick:(UIBarButtonItem *)btn{
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
