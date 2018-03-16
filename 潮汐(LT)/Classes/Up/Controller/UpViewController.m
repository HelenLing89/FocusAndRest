//
//  UpViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "UpViewController.h"
#import "FocusViewController.h"
#import "LTUpButton.h"
#import "LTBaseNavigationController.h"
#import "LTSleepViewController.h"

@interface UpViewController ()

@end

@implementation UpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGesture];
}


- (void)setUpGesture{
    
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(down)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:down];
    
}


- (void)down{
    
   
    
    [self dismissViewControllerAnimated:YES completion:nil ];
    
}

- (IBAction)fouseBtnClick:(LTUpButton *)sender {
    
    
    
    
    FocusViewController *focus = [[FocusViewController alloc] init];
    focus.view.backgroundColor = [UIColor clearColor];
    LTBaseNavigationController *naVc = [[LTBaseNavigationController alloc] initWithRootViewController:focus];
    
    [self presentViewController:naVc animated:YES completion:nil];
    
}

- (IBAction)sleepBtnClick {
    
    LTSleepViewController *sleep = [[LTSleepViewController alloc] init];
    sleep.view.backgroundColor = [UIColor redColor];
    LTBaseNavigationController *naVc = [[LTBaseNavigationController alloc] initWithRootViewController:sleep];
    
    [self presentViewController:naVc animated:YES completion:nil];
    
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
