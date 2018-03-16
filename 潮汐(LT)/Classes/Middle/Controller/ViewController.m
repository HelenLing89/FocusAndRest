//
//  ViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/2.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "ViewController.h"
#import "DateView.h"
#import "DownViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet DateView *dateView;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    DateView *dateView = [DateView dateView];
    [self.view addSubview:dateView];
    
    _dateView = dateView;
    
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(up:)];
    [up setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:up];
    
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(down:)];
    [down setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:down];
    
}

- (void)up:(UISwipeGestureRecognizer *)up{
    
   
    
}


- (void)down:(UISwipeGestureRecognizer *)down{
    
    DownViewController *vc = [[DownViewController alloc] init];
    
    
    vc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
   // [self.view.window addSubview:vc.view];
    [self presentViewController:vc animated:YES completion:^{
    
     }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
