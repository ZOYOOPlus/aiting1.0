//
//  PlayerManager.h
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerManager : NSObject

+(instancetype)defaultManager;
// 播放音乐

- (AVAudioPlayer *)playingMusic:(NSString *)filename;
- (void)pauseMusic:(NSString *)filename;
- (void)stopMusic:(NSString *)filename;
- (void)stopPlay;
- (void)pausePlay;

- (AVAudioPlayer *)player;

//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;



@end
