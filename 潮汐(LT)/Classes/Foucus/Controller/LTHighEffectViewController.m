//
//  LTHighEffectViewController.m
//  
//
//  Created by 凌甜 on 2018/3/8.
//

#import "LTHighEffectViewController.h"
#import "FocusSwitchItem.h"
#import "FocusSettingGroup.h"

@interface LTHighEffectViewController ()

@end

@implementation LTHighEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"高效模式";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"general_arrow_left_white_32_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    
    [self setUpGroup0];
    [self setUpGroup1];
    

    
}

- (void)setUpGroup0{
    FocusSwitchItem *item = [FocusSwitchItem itemWithTitle:@"高效模式" style:@"default" subTitle:nil image:[UIImage imageNamed:@"control_help_white_24_normal"]];
    FocusSettingGroup *group = [FocusSettingGroup initWithItems:@[item]];
    group.headTitle = @"模式";
    [self.groups addObject:group];
}

- (void)setUpGroup1{
    FocusSwitchItem *item0 = [FocusSwitchItem itemWithTitle:@"自动开始休息" style:@"default" subTitle:nil image:nil];
    FocusSwitchItem *item1 = [FocusSwitchItem itemWithTitle:@"自动开始专注" style:@"default" subTitle:nil image:nil];
    FocusSettingGroup *group = [FocusSettingGroup initWithItems:@[item0,item1]];
    group.headTitle = @"自动计时";
    [self.groups addObject:group];
    
}


- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
