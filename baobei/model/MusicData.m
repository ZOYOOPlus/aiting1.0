//
//  MusicData.m
//  baobei
//
//  Created by 贺少虎 on 16/5/21.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "MusicData.h"

@implementation MusicData

- (void)setMusicURL:(NSString *)musicURL{
    _musicPic = musicURL;
    self.audioFileURL = [NSURL URLWithString:_musicPic];
    
    //    // 本地 测试
    //    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"congerfei" ofType: @"mp3"];
    //    self.audioFileURL  = [NSURL fileURLWithPath:soundFilePath];
    
}

@end
