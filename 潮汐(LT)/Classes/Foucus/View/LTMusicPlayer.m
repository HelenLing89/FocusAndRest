//
//  LTMusicPlayer.m
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/22.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "LTMusicPlayer.h"

@implementation LTMusicPlayer
+ (instancetype)playingMusicWithMusicName:(NSString *)musicName{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
    if (url == nil) {
        return  nil;
    }
    LTMusicPlayer *player = [[LTMusicPlayer alloc] initWithData:[NSData dataWithContentsOfURL:url] error:nil];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [player prepareToPlay];
    [player play];
    return player;
}
@end
