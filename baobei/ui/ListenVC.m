//
//  ListenVC.m
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ListenVC.h"
#import "MusicManager.h"
#import "DataManager.h"


static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kCurrentTimeKVOKey = &kCurrentTimeKVOKey;

static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface ListenVC ()

@property (nonatomic,strong) UIButton *playerButton;
@property (nonatomic,strong) UISlider *progressView;
@property (nonatomic,strong) UILabel *currentTimeLabel;
@property (nonatomic,strong) UILabel *durationLabel;
@property (nonatomic,strong) UIImageView *playerView;
@property (nonatomic,strong) UILabel *musicName;
@end

@implementation ListenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.75 blue:0.41 alpha:1];
    
    [self setUp];
    // 生成播放列表？
    
    if ([MusicManager shareInstance].status == DOUAudioStreamerIdle ||
        [MusicManager shareInstance].status == DOUAudioStreamerError ) {
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][0]];
        [self updatemusicName];
        
        [[MusicManager shareInstance] playCurrentMusic];
        [self setPlayButtonPlaying:YES];
    }else if ([MusicManager shareInstance].status == DOUAudioStreamerFinished || [MusicManager shareInstance].status == DOUAudioStreamerPaused){
        [self setPlayButtonPlaying:NO];
        [self updateCurrenTime];
        [self updateDuration];
        [self updatemusicName];
    }else{
        [self setPlayButtonPlaying:YES];
        [self updateCurrenTime];
        [self updateDuration];
        [self updatemusicName];
    }
    
//    [[MusicManager shareInstance] playCurrentMusic];

    
    [[MusicManager shareInstance] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [[MusicManager shareInstance] addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [[MusicManager shareInstance] addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:kCurrentTimeKVOKey];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[MusicManager shareInstance] removeObserver:self forKeyPath:@"status"];
    [[MusicManager shareInstance] removeObserver:self forKeyPath:@"duration"];
    [[MusicManager shareInstance] removeObserver:self forKeyPath:@"currentTime"];
}

- (UIButton *)playerButton{
    if (!_playerButton) {
        _playerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playerButton addTarget:self action:@selector(clickPlayerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerButton;
}

- (UILabel *)durationLabel{
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.text = @"00:00";
        _durationLabel.font = [UIFont systemFontOfSize:15];
        _durationLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.96 alpha:1];

    }
    return _durationLabel;
}

- (UILabel *)currentTimeLabel{
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.96 alpha:1];
        _currentTimeLabel.font = [UIFont systemFontOfSize:15];

        _currentTimeLabel.text = @"00:00";
    }
    return _currentTimeLabel;
}

- (UISlider *)progressView{
    if (!_progressView) {
        _progressView = [[UISlider alloc]init];
        _progressView.continuous = NO;
        _progressView.maximumTrackTintColor = [UIColor colorWithRed:0.95 green:0.83 blue:0.57 alpha:1];
        _progressView.minimumTrackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (UIImageView *)playerView{
    if (!_playerView) {
        _playerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fa.png"]];
    }
    return _playerView;
}

- (UILabel *)musicName{
    if (!_musicName) {
        _musicName = [[UILabel alloc] init];
        _musicName.textColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.96 alpha:1];
        _musicName.font = [UIFont systemFontOfSize:20];
    }
    return _musicName;
}

- (void)setPlayButtonPlaying:(BOOL)playing{
    if (playing) {
        [self.playerButton setImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateNormal];
        [self.playerButton setImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateHighlighted];
    }else{
        [self.playerButton setImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateNormal];
        [self.playerButton setImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateHighlighted];
    }
}

- (void)setUp{
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.currentTimeLabel];
    [self.view addSubview:self.durationLabel];
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.playerButton];
    [self.view addSubview:self.musicName];

    //布局
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(710/2, 712/2));
        make.centerY.equalTo(self.view.mas_centerY).offset(-30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.playerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.playerView.mas_centerX);
        make.centerY.equalTo(self.playerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200/2, 200/2));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-20);
        make.height.mas_equalTo(3);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
    }];
    
    [self.currentTimeLabel sizeToFit];
    [self.durationLabel sizeToFit];

    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_left);
        make.bottom.equalTo(self.progressView.mas_top).offset(-10);

    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.progressView.mas_right);
        make.bottom.equalTo(self.progressView.mas_top).offset(-10);
    }];
    
    // UI 测试
    self.musicName.text = @"虫儿飞";
    
    [self.musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(30);
    }];
}

#pragma mark kvo

- (void)updateCurrenTime{
    CGFloat duration =[MusicManager shareInstance].currentTime;
    NSInteger m = (NSInteger) duration / 60;
    NSInteger s = (NSInteger)(duration - m  * 60);

    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02zi:%02zi",m,s];
    _progressView.value = [MusicManager shareInstance].currentTime/[MusicManager shareInstance].duration;
    if ([self.durationLabel.text isEqualToString:@"00:00"]) {
        [self updateDuration];
    }
}

- (void)updateDuration{
    CGFloat duration =[MusicManager shareInstance].duration;
    NSInteger m = (NSInteger) duration / 60;
    NSInteger s = (NSInteger)(duration - m  * 60);
    self.durationLabel.text = [NSString stringWithFormat:@"%02zi:%02zi",m,s];

}

- (void)updatemusicName{
    self.musicName.text = [MusicManager shareInstance].currentMusic.name;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    if (context == kStatusKVOKey) {
    
    } else if (context == kDurationKVOKey) {
        [self updateDuration];
    } else if (context == kCurrentTimeKVOKey) {
        [self updateCurrenTime];
    }else{
    
    }
}

#pragma mark action

- (void)clickPlayerButton:(id)sender{
    if ([MusicManager shareInstance].status == DOUAudioStreamerFinished ||
        [MusicManager shareInstance].status == DOUAudioStreamerIdle
        ) {
        [[MusicManager shareInstance] playCurrentMusic];
        [self setPlayButtonPlaying:YES];
    }else if([MusicManager shareInstance].status == DOUAudioStreamerPaused){
        [[MusicManager shareInstance] resumeCurrentMusic];
        [self setPlayButtonPlaying:YES];
    }else{
        [[MusicManager shareInstance] pauseCurrentMusic];
        [self setPlayButtonPlaying:NO];
    }
}

@end
