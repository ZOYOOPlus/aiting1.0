//
//  MusicManager.h
//  baobei
//
//  Created by 贺少虎 on 16/5/21.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicData.h"

@interface MusicManager : NSObject

@property (nonatomic,strong) MusicData * currentMusic;

@property (nonatomic,assign) DOUAudioStreamerStatus status;
@property (nonatomic,assign) CGFloat currentTime;
@property (nonatomic,assign) CGFloat duration;


+ (instancetype)shareInstance;

- (void)pauseCurrentMusic;
- (void)playCurrentMusic;
- (void)stopCurrentMusic;
- (void)resumeCurrentMusic;

@end
