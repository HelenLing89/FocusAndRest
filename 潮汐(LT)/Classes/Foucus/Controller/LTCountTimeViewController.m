//
//  LTCountTimeViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/8.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "LTCountTimeViewController.h"
#import "LTBaseNavigationController.h"
#import "FocusSettingViewController.h"

@interface LTCountTimeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) NSArray *focusTime;
//@property (nonatomic,strong) NSString *time;
@end

@implementation LTCountTimeViewController

//- (NSString *)time{
//    if (_time == nil) {
//        _time = @"20分钟";
//    }
//    return _time;
//}


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
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
    [self setUpPickView];
    
}

- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)confirm{
    if ([_delegate respondsToSelector:@selector(countTimeVc:didSelectTime:)]) {
        [_delegate countTimeVc:self didSelectTime:self.time];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setTime:(NSString *)time{
    
    _time = time;
   
    if (time == nil){
        time = @"20分钟";
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:time];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int  number;
    [scanner scanInt:&number];
    NSString *string = [NSString stringWithFormat:@"%d",number];
    NSArray *array = self.focusTime[0];
    NSInteger row = (NSInteger)[array indexOfObject:string];
    [_pickerView selectRow:row inComponent:0 animated:NO];
    
    }
    



- (void)viewDidLayoutSubviews{
    
    self.navigationController.view.frame = CGRectMake(20, screenH -64-200-10, screenW-40, 64+200);
    self.navigationController.view.layer.cornerRadius = 3;
    self.navigationController.view.layer.masksToBounds = YES;
    
    
   // self.view.frame = CGRectMake(0, screenH - 250, screenW, 250);
    //self.view.backgroundColor = [UIColor redColor];
    
    
}

- (void)setUpPickView{
    
    UIPickerView *pickerView =  [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, screenW-40, 250)];
    self.pickerView = pickerView;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((screenW-40)*0.5+20), 114, 40, 20)];
    label.text = @"分钟";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [_pickerView addSubview:label];
    [self.view addSubview:pickerView];
    
    }


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    // NSLog(@"%ld",self.focusTime.count);
    return self.focusTime.count;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    // NSLog(@"%ld",[self.focusTime[component] count]);
    return [self.focusTime[component] count];
    
    
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    UILabel *label = [[UILabel alloc] init];
    
    NSString *string = [NSString stringWithFormat:@"%@",self.focusTime[0][row]];
    
    NSMutableAttributedString *attFirst = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableDictionary *firstAttribute = [NSMutableDictionary dictionary];
    firstAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:25];
    firstAttribute[NSForegroundColorAttributeName] = [UIColor blackColor];
    firstAttribute[NSStrokeWidthAttributeName] = @-3;
    firstAttribute[NSStrokeColorAttributeName] = [UIColor blackColor];
    [attFirst setAttributes:firstAttribute range:NSMakeRange(0, attFirst.length)];
    label.attributedText = attFirst;
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    return  label;
    
    
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *time = [NSString stringWithFormat:@"%@分钟",self.focusTime[component][row]];
    
    self.time = time;
    
    
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
