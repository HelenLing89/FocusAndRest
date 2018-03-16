//
//  FocusViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/5.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusViewController.h"
#import "FocusRoundView.h"
#import "EqualierViewController.h"
#import "LTBaseNavigationController.h"
#import "SceneViewController.h"
#import "FocusCenterView.h"
#import "CircleAnimationView.h"
#import "UIButton+Extension.h"
#import "UIView+LTExtension.h"
#import <Masonry.h>
#import <POP.h>


@interface FocusViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet FocusCenterView *centerView;

@property (weak, nonatomic)  FocusRoundView *roundView;
@property (strong,nonatomic) NSArray *focusTime;
@property (strong,nonatomic) UIPickerView *pickerView;
@property (strong,nonatomic) NSArray *weathers;
@property (strong,nonatomic) NSArray *colors;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) NSMutableArray *roundViews;
@property (strong,nonatomic) UIButton *startBtn;
@property (strong,nonatomic) UIButton *pauseBtn;
@property (strong,nonatomic) UIButton *goOnBtn;
@property (strong,nonatomic) UIButton *giveUpBtn;
@property (strong,nonatomic) CircleAnimationView *circleView;

@end

@implementation FocusViewController



- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(change) userInfo:nil repeats:YES];
        
    }
    return _timer;
    
}


- (NSMutableArray *)roundViews{
    if (_roundViews == nil) {
        _roundViews = [NSMutableArray array];
        
    }
    return _roundViews;
    
}



- (NSArray *)colors{
    if (_colors == nil) {
        _colors = [NSArray array];
        _colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor grayColor]];
    }
    
    return _colors;
    
}


- (NSArray *)weathers{
    
    if (_weathers == nil) {
        _weathers = [NSArray array];
        _weathers = @[@"海洋",@"雨天",@"冥想"];
    }
    return _weathers;
}

- (UIPickerView *)pickerView{
    
    if (_pickerView == nil) {
     _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
     _pickerView.delegate = self;
     _pickerView.dataSource = self;
     _pickerView.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(145, 114, 40, 20)];
    label.text = @"分钟";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    
    [_pickerView addSubview:label];
        
    }
    
    return _pickerView;
    
}



- (NSArray *)focusTime{
    if (_focusTime == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"focusTimePlist.plist" ofType:nil];
        
      //  _fou = [NSArray arrayWithContentsOfFile:pathFile];
        _focusTime = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _focusTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"toolbar_equalizer_black_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(equalierClick:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"general_close_black_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(closeBtn:)];
    [self setUpScrollView];
    [self setUpButton];
  
}

- (void)change{
    
    self.roundView.subviews[0].hidden = NO;
    [self.pickerView removeFromSuperview];
    self.pickerView = nil;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setUpScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    self.scrollView = scrollView;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(screenW*self.weathers.count, 0);
    //self.scrollView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:self.scrollView atIndex:0];
    for (int i = 0; i<self.weathers.count;i ++ ) {
        UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(i*screenW, 0, screenW,screenH)];
        view.userInteractionEnabled = YES;
        UIColor *color = self.colors[i];
        view.backgroundColor = color;
        FocusRoundView *roundView = [FocusRoundView focusRoundView];
        //self.roundView = roundView;
        roundView.bounds = CGRectMake(0, 0, 250, 250);
        roundView.center = CGPointMake(self.scrollView.center.x, 250);
        roundView.weatherStr = self.weathers[i];
        roundView.string = @"25:00";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [roundView addGestureRecognizer:tap];
        [self.roundViews insertObject:roundView atIndex:i];
        [view addSubview:roundView];
        [self.scrollView addSubview:view];
       
    }

}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    CGPoint tapP = [tap locationInView:self.scrollView];
    NSInteger i = tapP.x / screenW;
    self.roundView = self.roundViews[i];
    self.roundView.subviews[0].hidden = YES;
    NSLog(@"%@",self.roundView.subviews[0]);
    [self.roundView addSubview:self.pickerView];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
   
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.focusTime.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.focusTime[component] count];
    
    
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    UILabel *label = [[UILabel alloc] init];
    
    NSString *string = [NSString stringWithFormat:@"%@",self.focusTime[0][row]];
    
    NSMutableAttributedString *attFirst = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableDictionary *firstAttribute = [NSMutableDictionary dictionary];
    firstAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    firstAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    firstAttribute[NSStrokeWidthAttributeName] = @-3;
    firstAttribute[NSStrokeColorAttributeName] = [UIColor whiteColor];
    [attFirst setAttributes:firstAttribute range:NSMakeRange(0, attFirst.length)];
    label.attributedText = attFirst;
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    return  label;
    
    
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.roundView.string = [NSString stringWithFormat:@"%@:00",self.focusTime[component][row]];
    
    
}


- (void)closeBtn:(UIButton *)sender {
    if (self.circleView) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出专注吗?" message:@"退出专注后,本次专注将失败." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *exit = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:exit];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:cancel];
       // [alert.view pop_addAnimation:animtion forKey:nil];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)equalierClick:(UIButton *)sender {
    EqualierViewController *vc = [[EqualierViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    
}

- (IBAction)sceneClick:(UIButton *)sender{
    SceneViewController *scene = [[SceneViewController alloc] init];
    LTBaseNavigationController *Navc = [[LTBaseNavigationController alloc] initWithRootViewController:scene];
    Navc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:Navc animated:YES completion:nil];
    
}

- (void)setUpButton{
    UIButton *goOn = [UIButton buttonWithTitle:@"继续" titleColor:[UIColor grayColor] backgroudColor:[UIColor whiteColor]];
    self.goOnBtn = goOn;
    goOn.hidden = YES;
    [self.centerView addSubview:goOn];
    [goOn addTarget:self action:@selector(goOnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *giveUp = [UIButton buttonWithTitle:@"放弃" titleColor:[UIColor whiteColor] backgroudColor:[UIColor clearColor]];
    self.giveUpBtn = giveUp;
    giveUp.hidden = YES;
    [self.centerView addSubview:giveUp];
    [giveUp addTarget:self action:@selector(giveUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *pause = [UIButton buttonWithTitle:@"暂停" titleColor:[UIColor whiteColor] backgroudColor:[UIColor clearColor]];
    self.pauseBtn = pause;
    pause.hidden = YES;
     [self.centerView addSubview:pause];
    [pause addTarget:self action:@selector(pauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *startFocusBtn = [UIButton buttonWithTitle:@"开始专注" titleColor:[UIColor grayColor] backgroudColor:[UIColor whiteColor]];
    self.startBtn = startFocusBtn;
    self.startBtn.hidden = NO;
    [self.centerView addSubview:startFocusBtn];
    [startFocusBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.startBtn.width = self.centerView.width /3;
    self.startBtn.height = 40;
    self.startBtn.centerY = self.centerView.height * 4/5;
    self.startBtn.centerX = self.centerView.centerX;
    self.pauseBtn.center = self.startBtn.center;
    self.pauseBtn.height = self.startBtn.height;
    self.pauseBtn.width = self.startBtn.width/3*2;
    
    [self.goOnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pauseBtn);
    }];
    [self.giveUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.pauseBtn);
    }];
    
}

- (void)startBtnClick{
    CGFloat offSetX= self.scrollView.contentOffset.x;
    NSInteger i = offSetX / screenW;
    self.roundView = self.roundViews[i];
    [self.roundView starAnimatewithTime:self.roundView.string weather:self.roundView.weatherStr];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI);
    animation.duration = 0.25;
    animation.repeatCount = 1;
    [self.startBtn.layer addAnimation:animation forKey:nil];
    self.startBtn.hidden = YES;
    self.pauseBtn.hidden = NO;
    [self addCircleAnimate];
    
}

- (void)pauseBtnClick{
    
    [self.roundView pauseAnimate];
    [UIView animateWithDuration:0.25 animations:^{
        self.goOnBtn.hidden = NO;
        self.giveUpBtn.hidden = NO;
        self.goOnBtn.centerX = self.centerView.width * 1/3;
        self.giveUpBtn.centerX = self.centerView.width *2/3;
        self.pauseBtn.hidden = YES;
    } completion:^(BOOL finished) {
        [self.circleView removeFromSuperview];
    }];
    
    
}

- (void)goOnBtnClick{
    
    [self.roundView goOnAnimate];
    [UIView animateWithDuration:0.25 animations:^{
        self.goOnBtn.centerX = self.centerView.centerX;
        self.giveUpBtn.centerX = self.centerView.centerX;
        self.goOnBtn.hidden = YES;
        self.giveUpBtn.hidden = YES;
        self.pauseBtn.hidden = NO;
    } completion:nil];
    [self addCircleAnimate];
    
    
}


-(void)giveUpBtnClick{
    
    [self.roundView stopAnimatewithTime:self.roundView.string weather:self.roundView.weatherStr];
    [UIView animateWithDuration:0.25 animations:^{
        self.goOnBtn.centerX = self.centerView.centerX;
        self.giveUpBtn.centerX = self.centerView.centerX;
        self.goOnBtn.hidden = YES;
        self.giveUpBtn.hidden = YES;
        self.startBtn.hidden = NO;
    } completion:nil];
    [self.circleView removeFromSuperview];
    
    
    
}


- (void)addCircleAnimate{
    
    CircleAnimationView *circleView = [[CircleAnimationView alloc] init];
    [self.scrollView insertSubview:circleView aboveSubview:self.roundView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.roundView);
    }];
    self.circleView = circleView;
    
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
