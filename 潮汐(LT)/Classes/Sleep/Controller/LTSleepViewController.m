//
//  LTSleepViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/15.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "LTSleepViewController.h"
#import "SleepCenterView.h"
#import "UIPickerView+Extension.h"
#import "SleepRespiteCenterView.h"
#import "NSString+Extension.h"
#import <Masonry.h>


@interface LTSleepViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) SleepCenterView *centerView;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) NSArray *timeArr;
@property (strong,nonatomic) UIButton *roundBtn;
@property (strong,nonatomic) UIView *collectionView;
@property (strong,nonatomic) SleepRespiteCenterView *respiteCenterView;
@property (strong,nonatomic) UIPickerView *pickerView;
@property (strong,nonatomic) NSArray *time;
@property (weak, nonatomic) IBOutlet UIButton *sleepBtn;
@property (weak, nonatomic) IBOutlet UIButton *respiteBtn;
@property (strong,nonatomic) UILabel *detailLabel;
@property (strong,nonatomic) UILabel *detailLabel2;
- (IBAction)sleepBtnClick;

- (IBAction)respiteBtnClick;

@end

@implementation LTSleepViewController


- (NSArray *)time{
    if (_time == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"focusTimePlist.plist" ofType:nil];
        _time = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _time;
}
- (NSArray *)timeArr{
    if (_timeArr == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"time.plist" ofType:nil];
        _timeArr = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _timeArr;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeChange) userInfo:nil repeats:NO];
        
        
    }
    return _timer;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"toolbar_equalizer_black_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(equalierClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"general_close_black_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(closeBtn)];
    [self setUpScrollView];
    [self setUpRoundBtn];
    self.view.backgroundColor = [UIColor redColor];
    
}



- (void)setUpScrollView{
    self.scrollView.contentSize = CGSizeMake(screenW *2, 0);
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self scrollViewDidEndDecelerating:self.scrollView];
    [self setUpCenterView];
    [self setUpRespiteView];

}

- (void)setUpRoundBtn{
    UIButton *roundBtn = [[UIButton alloc] init];
    [roundBtn setImage:[UIImage imageNamed:@"sleep_start_moon"] forState:UIControlStateNormal];
    [roundBtn setImage:[UIImage imageNamed:@"sleep_start_sun"] forState:UIControlStateSelected];
    [roundBtn sizeToFit];
    roundBtn.center = CGPointMake(screenW/2, screenH*4/5);
    self.roundBtn = roundBtn;
    [self.view addSubview:roundBtn];
    [self addAnimates];
    
}
- (void)addAnimates{
    
    CAKeyframeAnimation *animates = [CAKeyframeAnimation animation];
    animates.keyPath = @"position.y";
    CGFloat imageVY = screenH*4/5;
    animates.values = @[@(imageVY-10),@(imageVY-5),@(imageVY),@(imageVY+5),@(imageVY+10),@(imageVY+5),@(imageVY),@(imageVY-5),@(imageVY-10)];
    animates.duration = 5;
    animates.repeatCount = MAXFLOAT;
    animates.removedOnCompletion = NO;
    animates.fillMode = kCAFillModeForwards;
    [self.roundBtn.layer addAnimation:animates forKey:nil];
}

- (void)setUpCenterView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenW, 250)];
    [self.scrollView addSubview:view];
    SleepCenterView *center = [SleepCenterView sleepCenterView];
    center.frame = CGRectMake(0, 0, screenW, 200);
    [view addSubview:center];
    self.centerView = center;
    [self setUpPickerView];
    UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake((screenW-140)/2,210, 140,40)];
    detailL.backgroundColor = [UIColor grayColor];
    detailL.textColor = [UIColor whiteColor];
    detailL.textAlignment = NSTextAlignmentCenter;
    detailL.numberOfLines = 2;
    detailL.font = [UIFont systemFontOfSize:12];
    self.detailLabel = detailL;
    [self setUpDetailLabelInfo];
    
    [view addSubview:detailL];
    
    [view addSubview:self.pickerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [center addGestureRecognizer:tap];
    
}
- (void)setUpDetailLabelInfo{
    NSInteger total = [self.centerView.restTime convertToTotalMinutefromString];
    NSInteger begin = total-25;
    NSString *beginString = [NSString convertToStringFromTotalMinute:begin];
    NSInteger delate = [self.centerView.restTime calculateDelateTimeFromString];
    if (delate/60<3) {
        self.detailLabel.text = [NSString stringWithFormat:@"将于%@~%@轻唤醒",beginString,self.centerView.restTime];
    }else{
        self.detailLabel.text = [NSString stringWithFormat:@"将于%@~%@轻唤醒预计睡眠时长%.1f小时",beginString,self.centerView.restTime,delate/60.0];
    }
    
}


- (void)setUpPickerView{
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0,screenW, 200)];
    pickView.backgroundColor = [UIColor redColor];
    self.pickerView = pickView;
    UILabel *label = [[UILabel alloc] init];
    label.center = CGPointMake(screenW/2, 100);
    label.bounds = CGRectMake(0,0,20,30);
    label.text = @":";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor whiteColor];
    [pickView addSubview:label];
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.hidden = YES;
    NSString *string = self.centerView.restTime;
    NSArray *strArr = [string componentsSeparatedByString:@":"];
    NSInteger index1 = [self.timeArr[0] indexOfObject:strArr[0]];
    NSInteger index2 = [self.timeArr[1] indexOfObject:strArr[1]];
    [pickView selectRow:index1 inComponent:0 animated:NO];
    [pickView selectRow:index2 inComponent:1 animated:NO];
}


- (void)setUpRespiteView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blueColor];
    view.frame = CGRectMake(screenW, 100, screenW, 250);
    [self.scrollView addSubview:view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenW, 40)];
    label.text = @"设置小憩时长";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor= [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];

    
    SleepRespiteCenterView *respiteCenterView = [SleepRespiteCenterView sleepRespiteCenterView];
    respiteCenterView.frame = CGRectMake(0, 70, screenW, 100);
    self.respiteCenterView = respiteCenterView;
    respiteCenterView.hidden = NO;
    [view addSubview:respiteCenterView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0,0,60,40);
    button.center = CGPointMake(screenW/2, 180);
    button.font = [UIFont systemFontOfSize:12];
    [button setTitle:@"自定义" forState:UIControlStateNormal];
    [button setTitle:@"基本" forState:UIControlStateSelected];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self setUpCollectionView];
    [view addSubview:self.collectionView];
    UILabel *detailL2 = [[UILabel alloc] initWithFrame:CGRectMake((screenW-140)/2,210, 140,40)];
    detailL2.backgroundColor = [UIColor grayColor];
    detailL2.textColor = [UIColor whiteColor];
    detailL2.textAlignment = NSTextAlignmentCenter;
    detailL2.numberOfLines = 2;
    detailL2.font = [UIFont systemFontOfSize:12];
    self.detailLabel2 = detailL2;
    
    [view addSubview:detailL2];
    
}

- (void)setUpDetailLabel2Info{
    
    
    
    
}

- (void)setUpCollectionView{
    
    UIView *collectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, screenW, 100)];
    self.collectionView = collectionView;
    collectionView.hidden = YES;
    UIImageView *imageDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down"]];
    [collectionView addSubview:imageDown];
    imageDown.center = CGPointMake(screenW/2, 5);
    UIImageView *imageUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_up"]];
    [collectionView addSubview:imageUp];
    imageUp.center = CGPointMake(screenW/2,100);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(screenW/2-10, 70, 30,20)];
    label.text = @"分钟";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    [collectionView addSubview:label];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 50;
    //layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(50, 40);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0,20, screenW, 40) collectionViewLayout:layout];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"sleep"];
    //self.collectionView = collctionView;
    collection.delegate = self;
    collection.dataSource = self;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
   // collection.hidden = YES;
   // collection.backgroundColor = [UIColor greenColor];
    [collectionView addSubview:collection];
                            
}


- (void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    self.respiteCenterView.hidden = !self.respiteCenterView.hidden;
    self.collectionView.hidden  = !self.collectionView.hidden;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.time.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return [self.time[section] count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sleep" forIndexPath:indexPath];
   // cell.frame = CGRectMake(0, 0, 50, 60);
   // cell.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 50, 40);
    label.text = [NSString stringWithFormat:@"%@",self.time[indexPath.section][indexPath.row]];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    return cell;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 60;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 70;
    
}
- (void)tap:(UIGestureRecognizer *)tap{
    
    [UIView animateWithDuration:2 animations:^{
        self.centerView.hidden =  YES;
        self.pickerView.hidden = NO;
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }];
   
}

- (void)timeChange{
    
   self.centerView.hidden = NO;
   self.pickerView.hidden = YES;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.timeArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   // NSLog(@"%lu",(unsigned long)[self.timeArr[component] count]);
    return [self.timeArr[component] count];
   
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    [self deleteSeperator:pickerView];
    
    UILabel *label = [[UILabel alloc] init];
    
    NSString *string = [NSString stringWithFormat:@"%@",self.timeArr[component][row]];
    
    NSMutableAttributedString *attFirst = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableDictionary *firstAttribute = [NSMutableDictionary dictionary];
    firstAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:45];
    firstAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
   // firstAttribute[NSStrokeWidthAttributeName] = @-2;
    //firstAttribute[NSStrokeColorAttributeName] = [UIColor whiteColor];
    [attFirst setAttributes:firstAttribute range:NSMakeRange(0, attFirst.length)];
    label.attributedText = attFirst;
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    return  label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //self.centerView.restTime = [NSString stringWithFormat:@"%@:%@",self.timeArr[0],self.timeArr[1][row]];
    NSString *string = self.centerView.restTime;
    NSArray *strArr = [string componentsSeparatedByString:@":"];
    if (component == 0) {
        self.centerView.restTime = [NSString stringWithFormat:@"%@:%@",self.timeArr[component][row],strArr[1]];
    }else{
        self.centerView.restTime = [NSString stringWithFormat:@"%@:%@",strArr[0],self.timeArr[component][row]];
    }
    
   
    [self timeChange];
    [self setUpDetailLabelInfo];
    [self.timer invalidate];
    self.timer = nil;
    
}




- (void)deleteSeperator:(UIView *)view{
    if (view.subviews != 0) {
        if (view.bounds.size.height < 5) {
            view.backgroundColor = [UIColor clearColor];
        }
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self deleteSeperator:obj];
        }];
    }
}
- (void)closeBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)equalierClick{
    
   
    
    
    
}


- (IBAction)sleepBtnClick {
    self.sleepBtn.selected = YES;
    self.respiteBtn.selected = NO;
    self.roundBtn.selected = NO;
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    
}

- (IBAction)respiteBtnClick {
    self.sleepBtn.selected = NO;
    self.respiteBtn.selected = YES;
    self.roundBtn.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(screenW, 0) animated:YES];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x /screenW;
    if (i == 0) {
        self.sleepBtn.selected = YES;
        self.respiteBtn.selected = NO;
        self.roundBtn.selected = NO;
    }else{
        self.sleepBtn.selected = NO;
        self.respiteBtn.selected = YES;
        self.roundBtn.selected = YES;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
    

@end
