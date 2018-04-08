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
#import "DownViewController.h"

@interface UpViewController ()

@end

@implementation UpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:150/256.0 alpha:0.5];
    [self setUpGesture];
    [self setUpBlurView];
    
}

- (void)setUpBlurView{
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = ScreenBounds;
    [self.view insertSubview:visualEffectView atIndex:0];
    
    
}


- (void)setUpGesture{
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //down.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:tap];
    
}


- (void)tap{
    
    DownViewController *down = (DownViewController *)self.presentingViewController;
    if (down.toolBarBlock!=nil) {
        down.toolBarBlock();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self removeFromParentViewController];
    //[self.view removeFromSuperview];
    
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
