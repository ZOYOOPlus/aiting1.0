//
//  MusicManager.m
//  baobei
//
//  Created by 贺少虎 on 16/5/21.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "MusicManager.h"
#import "HCommon.h"
#import <MediaPlayer/MediaPlayer.h>

static MusicManager *_manager;

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kcurrentTimeKVOKey = &kcurrentTimeKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;

static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface MusicManager()

@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic) NSTimer *musicDurationTimer;

@end

@implementation MusicManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MusicManager alloc] init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.status = DOUAudioStreamerIdle;
    }
    return self;
}

- (void)removeStreamerObserver {
    [_streamer removeObserver:self forKeyPath:@"status"];
    [_streamer removeObserver:self forKeyPath:@"duration"];
 //   [_streamer removeObserver:self forKeyPath:@"currentTime"];
    [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
}


- (void)addStreamerObserver {
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
}

- (void)playCurrentMusic{
    
    if (_currentMusic == nil) {
        DLog(@"请先设置音乐实体");
        return;
    }
    if (_streamer) {
        @try {
            [self removeStreamerObserver];
        } @catch (NSException *exception) {
            
        }
        _streamer = nil;
    }
    _streamer = [DOUAudioStreamer streamerWithAudioFile:self.currentMusic];
    [self addStreamerObserver];
    [self.streamer play];
    _musicDurationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime:) userInfo:nil repeats:YES];
    [self configNowPlayingInfoCenter];
}

- (void)pauseCurrentMusic{
    if (_streamer) {
        if ([_streamer status] ==  DOUAudioStreamerPlaying) {
            [_streamer pause];
        }
    }
}

- (void)resumeCurrentMusic{
    if (_streamer) {
        [_streamer play];
    }
}

- (void)stopCurrentMusic{
    if (_streamer) {
        if ([_streamer status] ==  DOUAudioStreamerPlaying) {
            [_streamer stop];
        }
        [self removeStreamerObserver];
        _streamer = nil;
    }

       self.status = DOUAudioStreamerIdle;
}

- (void)updateCurrentTime:(id)timer{
    if (!_streamer) {
        return;
    }
    if (_streamer.status == DOUAudioStreamerFinished) {
        return;
    }
    if (self.currentTime != _streamer.currentTime) {
        self.currentTime = _streamer.currentTime;
//        NSLog(@"%f",self.duration);

//        [self setCurrentTime:_streamer.currentTime];
    }
    if (self.duration < 0.001) {
        self.duration = _streamer.duration;
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if (context == kStatusKVOKey) {
        self.status = _streamer.status;
    } else if (context == kDurationKVOKey) {
//        [self setDuration:_streamer.duration];
        [self performSelector:@selector(updateCurrentTime:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }else if (context == kcurrentTimeKVOKey){
        //没卵用 并不会调用
        
    }else if (context == kBufferingRatioKVOKey) {
        //目测是加载进度
        
        //        [self performSelector:@selector(updateBufferingStatus)
        //                     onThread:[NSThread mainThread]
        //                   withObject:nil
        //                waitUntilDone:NO];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//设置后台专辑名称

- (void)configNowPlayingInfoCenter{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:self.currentMusic.musicURL] options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        
        [dict setObject:self.currentMusic.name forKey:MPMediaItemPropertyTitle];
        [dict setObject:self.currentMusic.artistName forKey:MPMediaItemPropertyArtist];
        [dict setObject:@"专辑名" forKey:MPMediaItemPropertyAlbumTitle];
        
        [dict setObject:@(audioDurationSeconds) forKey:MPMediaItemPropertyPlaybackDuration];
        CGFloat playerAlbumWidth = (SCREEN_WIDTH - 16) * 2;
        UIImageView *playerAlbum = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, playerAlbumWidth, playerAlbumWidth)];
        UIImage *placeholderImage = [UIImage imageNamed:@"head.jpg"];
        
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:placeholderImage];
        playerAlbum.contentMode = UIViewContentModeScaleAspectFill;
        
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];

        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

@end
