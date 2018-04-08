//
//  GuideViewController.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/22.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideItem.h"
#import "GuideScrollView.h"
#import <AVFoundation/AVFoundation.h>
#import "DownViewController.h"
#import "UpViewController.h"
@interface GuideViewController ()
@property (strong,nonatomic) NSMutableArray *guideArr;
@property (strong,nonatomic) GuideScrollView *guideView;
@property (strong,nonatomic) AVPlayer *player;
@property (strong,nonatomic) UIView *playView;

@end

@implementation GuideViewController

#pragma 懒加载
- (NSMutableArray *)guideArr{
    if (_guideArr == nil) {
        _guideArr = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"guideInfor.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        
        for (NSDictionary *dict in arr) {
            GuideItem *item = [GuideItem guideItemWithDict:dict];
            [_guideArr addObject:item];
        }
    }
    return _guideArr;
}
- (UIView *)playView{
    if (_playView == nil) {
        _playView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:_playView atIndex:0];
    }
    return _playView;
    
}
- (AVPlayer *)player{
    if(_player == nil){
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"intro.mp4" withExtension:nil];
        _player = [AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.videoGravity = AVLayerVideoGravityResize;
        playerLayer.frame = self.view.bounds;
        [self.playView.layer addSublayer:playerLayer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _player;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGuideView];
    [self.player play];
    
}
-(void)setUpGuideView{
    GuideScrollView *guideView = [GuideScrollView guideScrollView];
    guideView.frame = self.view.bounds;
    guideView.backgroundColor = [UIColor clearColor];
    guideView.inforArr = (NSArray *)self.guideArr;
    self.guideView = guideView;
    [self.view addSubview:guideView];

    
}


- (void)playbackFinished{
    
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
