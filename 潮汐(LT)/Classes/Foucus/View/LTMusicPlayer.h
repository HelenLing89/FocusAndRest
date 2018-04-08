//
//  LTMusicPlayer.h
//  潮汐(LT)
//
//  Created by 凌甜 on 2018/3/22.
//  Copyright © 2018年 凌甜. All rights reserved.
//
#import <Foundation/Foundation.h>
//#import <AVFAudio/AVFAudio.h>
#import <AVFoundation/AVFoundation.h>

@interface LTMusicPlayer : AVAudioPlayer
+(instancetype)playingMusicWithMusicName:(NSString *)musicName;

@end
