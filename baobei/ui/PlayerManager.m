//
//  PlayerManager.m
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "PlayerManager.h"

@interface PlayerManager ()
@property (nonatomic, strong) NSMutableDictionary *musicPlayers;
@property (nonatomic, strong) NSMutableDictionary *soundIDs;
@property  (nonatomic,strong) AVAudioPlayer *player;
@end


static  PlayerManager  *_instance = nil;
@implementation PlayerManager

+(instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
    
}

- (instancetype)init
{
    __block PlayerManager *temp = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((temp = [super init]) != nil) {
            _musicPlayers = [NSMutableDictionary dictionary];
            _soundIDs = [NSMutableDictionary dictionary];
        }
    });
    self = temp;
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//播放音乐
- (AVAudioPlayer *)playingMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return nil;
    
    _player = self.musicPlayers[filename];      //先查询对象是否缓存了
    
    if (!_player) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url)  return nil;
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        if (![_player prepareToPlay]) return nil;
        
        self.musicPlayers[filename] = _player;            //对象是最新创建的，那么对它进行一次缓存
    }
    
    if (![_player isPlaying]) {                 //如果没有正在播放，那么开始播放，如果正在播放，那么不需要改变什么
        [_player play];
    }
    return _player;
}

- (void)pauseMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    if ([player isPlaying]) {
        [player pause];
    }
}
//- (AVAudioPlayer  *)player{
//
//    if (_player ==nil) {
//        
//      _player = [[AVAudioPlayer alloc]init];
//    }
//        return _player;
//}

- (void)stopPlay

{

     if (self.player.url){
         [self.player  stop];
     }
}

- (void)pausePlay

{
    if (self.player.url){
        [self.player  pause];
        }
}


- (void)stopMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    [player stop];
}

//播放音效
- (void)playSound:(NSString *)filename
{
    if (!filename) return;
    
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        self.soundIDs[filename] = @(soundID);
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID);
}

//摧毁音效
- (void)disposeSound:(NSString *)filename
{
    if (!filename) return;
    
    
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [self.soundIDs removeObjectForKey:filename];    //音效被摧毁，那么对应的对象应该从缓存中移除
    }
}
@end

