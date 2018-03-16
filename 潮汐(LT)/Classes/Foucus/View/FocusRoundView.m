//
//  FocusRoundView.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/5.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "FocusRoundView.h"
#import "CircleAnimationView.h"

@interface FocusRoundView ()
{
    
    NSString * _temStr;
    NSString * _weather;
    NSString * _time;
}
@property (weak, nonatomic) IBOutlet UILabel *focusTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) CGFloat angle;
@property (nonatomic,assign) CGFloat roundAngle;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) UIBezierPath *path;
//@property (nonatomic,assign) CGFloat startA;


//@property (strong,nonatomic) UIPickerView *pickerView;

@end

@implementation FocusRoundView

- (UIBezierPath *)path{
    if (_path == nil) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange)userInfo:nil repeats:YES];
    }
    return _timer;
    
}


+ (instancetype)focusRoundView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpLayer];
        
    }
    
    return self;
}



- (void)setUpLayer{
    self.layer.borderWidth = 3;
    self.layer.borderColor = [UIColor colorWithRed:220/256.0 green:220/256.0 blue:220/256.0 alpha:0.5].CGColor;
    self.layer.cornerRadius = 123;
    self.layer.masksToBounds = YES;
    
}




- (void)starAnimatewithTime:(NSString*)time weather:(NSString *)weather{
    [self addAnimateWithlayer:self.weatherLabel.layer];
    _time = time;
    _weather = weather;
    self.weatherLabel.text = time;
    self.string = weather;
    NSString *timeStr = self.weatherLabel.text;
    NSArray *times = [timeStr componentsSeparatedByString:@":"];
    NSInteger total = [times[0] integerValue ]* 60+ [times[1] integerValue];
    self.angle = 360.000/total/180.0000*M_PI;
    [self.timer setFireDate:[NSDate date]];
    
    
}

- (void)addAnimateWithlayer:(CALayer *)layer{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI *2);
    animation.duration = 0.25;
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    
    [layer addAnimation:animation forKey:nil];
    
    
}

- (void)addCirCleAnimate{
    
    
    
    
    
    
    
}
- (void)timeChange{
    NSString *timeStr = self.weatherLabel.text;
    NSArray *time = [timeStr componentsSeparatedByString:@":"];
    NSInteger total = [time[0] integerValue ]* 60+ [time[1] integerValue];
    NSInteger min = (total-1)/60;
    NSInteger second = (total -1)%60;
    self.weatherLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)min,(long)second];
    
    [self setNeedsDisplay];
    
    
}

- (void)drawRect:(CGRect)rect{
    
    CGFloat radius = self.frame.size.width * 0.5;
    
    CGPoint center = CGPointMake(radius,radius);
    
    self.roundAngle += self.angle;
    CGFloat starA  = - M_PI_2;
    CGFloat endA  = starA + self.roundAngle;
    
   UIBezierPath *path = [UIBezierPath   bezierPathWithArcCenter:center radius:radius-2 startAngle:starA endAngle:endA clockwise:YES];
    //[self.path addClip];
    
    //self.path.lineWidth = 3;
   // [self.path addLineToPoint:center];

   [[UIColor whiteColor] setStroke];
    
    [path stroke];
    
    
}


- (void)pauseAnimate{
    [self.timer setFireDate:[NSDate distantFuture]];
    
    
    
}

- (void)goOnAnimate{
    
    [self.timer setFireDate:[NSDate date]];
    
}

- (void)stopAnimatewithTime:(NSString*)time weather:(NSString *)weather{
    [self addAnimateWithlayer:self.weatherLabel.layer];
    
    self.weatherLabel.text = _weather;
    self.string = _time;
    [self.timer invalidate];
    self.timer = nil;
    self.angle = 0;
    self.roundAngle = 0;
    self.path = nil;
    [self setNeedsDisplay];
    
   
    
}


- (void)setString:(NSString *)string{
    
    _string = string;
//    self.subviews[0].hidden = NO;
//    [self.pickerView removeFromSuperview];
    self.focusTimeLabel.text = string;
    
}

- (void)setWeatherStr:(NSString *)weatherStr{
    
    _weatherStr = weatherStr;
    self.weatherLabel.text = weatherStr;
}



@end
