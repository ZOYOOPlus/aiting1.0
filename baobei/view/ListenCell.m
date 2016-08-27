//
//  ListenCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ListenCell.h"
#import "LearnVC.h"
#import "PlayerManager.h"
#import "ListenData.h"
#import "DataManager.h"
#import "MusicManager.h"
@interface ListenCell()
@property (nonatomic,strong)NSURL *URL;
@end
@implementation ListenCell

//放大按钮的热区
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isPlay = NO;
        self.contentView.clipsToBounds = YES;
        self.layer.cornerRadius= 5.0f;
        [self.contentView addSubview:self.imageView];
        [self.imageView addSubview:self.play];
        [self.contentView addSubview:self.reward];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.leftNextBtn];
        [self.contentView addSubview:self.rightNextBtn];
        [self.contentView addSubview:self.playTime];
        [self.contentView addSubview:self.playTimes];
        [self.contentView addSubview:self.musicView];
        self.contentView.userInteractionEnabled = YES;
        
        NAKPlaybackIndicatorView *indicator = [[NAKPlaybackIndicatorView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:indicator];
        [indicator sizeToFit];
        
        [_play addTarget:self action:@selector(players) forControlEvents:UIControlEventTouchUpInside];
        _play.tag = 0;
        _play.adjustsImageWhenHighlighted = NO;
        
        [_leftNextBtn addTarget:self action:@selector(backPlayMusic) forControlEvents:UIControlEventTouchUpInside];
        
        [_rightNextBtn addTarget:self action:@selector(nextPlayMusic) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//   http://audio.xmcdn.com/group13/M05/6E/84/wKgDXVc7N33ST3ZuAFIFIhmC6ac098.m4a
//   http://audio.xmcdn.com/group16/M06/6E/3E/wKgDalc7NPfDsjEyAF5JwQWHKB0355.m4a


- (void)setListenData:(ListenData *)data{
    data.imageView.image = [UIImage imageNamed:@"01"];
    
}

- (UIButton *)leftNextBtn{
    if (!_leftNextBtn) {
        _leftNextBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_leftNextBtn setImage:[UIImage imageNamed:@"xxxx"] forState:UIControlStateNormal];
    }
    return _leftNextBtn;
}

- (UIButton *)rightNextBtn{
    
    if (!_rightNextBtn) {
        _rightNextBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_rightNextBtn setImage:[UIImage imageNamed:@"xxx"] forState:UIControlStateNormal];
    }
    return _rightNextBtn;
    
}

- (UIButton *)play{
    
    if (!_play) {
        _play = [[UIButton alloc]initWithFrame:CGRectZero];
        [_play setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
        [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateSelected];
    }
    
    return _play;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 10;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIImageView *)musicView{
    
    if (!_musicView) {
        _musicView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_musicView setUserInteractionEnabled:YES];
    }
    return _musicView;
}


- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_like"] highlightedImage:[UIImage imageNamed:@"home_like_high"]];
    }
    return _likeImageView;
}

- (UIButton *)reward{
    if (!_reward) {
        _reward = [[UIButton alloc] initWithFrame:CGRectZero];
        [_reward setTitle:@"打赏" forState:UIControlStateNormal];
        _reward.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [_reward setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_reward setUserInteractionEnabled:YES];
        [_reward addTarget:self action:@selector(payRMB) forControlEvents:UIControlEventTouchUpInside];
        // 255 102
    }
    return _reward;
    
}

- (UILabel *)playTime{
    if (!_playTime) {
        _playTime = [[UILabel alloc] init];
        _playTime.text = @"播放:";
        _playTime.font = [UIFont systemFontOfSize:11.0];
        _playTime.textColor = [UIColor grayColor];
    }
    return _playTime;
}

- (UILabel *)playTimes{
    
    if (!_playTimes) {
        _playTimes = [[UILabel alloc] init];
        _playTimes.text = @"1268";
        _playTimes.font = [UIFont systemFontOfSize:10.0];
        _playTimes.textColor = [UIColor blackColor];
        
    }
    return _playTimes;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:0 alpha:1];
        _name.font = [UIFont systemFontOfSize:16.0];
    }
    return _name;
}


- (NSURL *)musicURL{
    
    if (!_musicURL) {
        _musicURL = [[NSURL alloc]init];
    }
    return _musicURL;
}

- (void)setData:(ListenData *)data{
    
    self.imageView.image = [UIImage imageNamed:data.imageName];
    self.name.text = data.title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.7);
    }];
    
    [self.leftNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(fDeviceWidth * 0.03);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-55);
        make.size.mas_equalTo(CGSizeMake(25/2, 36/2));
    }];
    
    [self.rightNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-fDeviceWidth * 0.03);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-55);
        make.size.mas_equalTo(CGSizeMake(25/2, 36/2));
    }];
    
    //   [self.reward sizeToFit];
    [self.reward mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(fDeviceWidth*0.05);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(36, 10));
    }];
    
    [self.musicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(20*0.8, 20*0.8));
        
    }];
    
    
    [self.play mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-fDeviceWidth*0.16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-fDeviceWidth*0.19);
        make.size.mas_equalTo(CGSizeMake(fDeviceWidth*0.13, fDeviceWidth*0.13));
    }];
    
    
    [self.playTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-fDeviceWidth *0.055);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(60, 10));
    }];
    
    [self.playTimes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-fDeviceWidth *0.065);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 10));
    }];
    [self.name sizeToFit];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        
    }];
}
- (void)players{
    
    if(_play.tag == 0){
        
        [self plays];
        
    }else
        
    {
        [self stops];
        
    }
}

- (void)plays{
    [_musicView setHidden:NO];
    if ([self.delegate respondsToSelector:@selector(cellStopAnimationwithCell:)]) {
        [self.delegate cellStopAnimationwithCell:self];
        
    }
    
    [self startAnimation];
    [self  runStar];
    [self initRecordSession];
    _play.selected = YES;
    [[MusicManager shareInstance]stopCurrentMusic];
  //  [[PlayerManager defaultManager]stopPlay];
    
    
    if( _play.tag == 0&&[_name.text isEqualToString:@"哄睡"]){
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];
        
        _play.tag = 1;
        
    }else if(_play.tag == 0&&[_name.text isEqualToString:@"80后"]){
        
//        [[MusicManager shareInstance]stopCurrentMusic];
//        [[PlayerManager defaultManager] playingMusic:@"2015.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        _play.tag = 1;
        
    }else if(_play.tag == 0&&[_name.text isEqualToString:@"托马斯"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"ABC.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        
        _play.tag = 1;
    }else if(_play.tag == 0&&[_name.text isEqualToString:@"西游记"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        
        _play.tag = 1;
        
    }else if(_play.tag == 0&&[_name.text isEqualToString:@"双语"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        _play.tag = 1;
        
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"童话故事"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        _play.tag = 1;
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"故事"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        
        _play.tag = 1;
        
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"想象力"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        _play.tag = 1;
        
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"记忆力"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        _play.tag = 1;
        
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"逻辑思维"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        
        _play.tag = 1;
        
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"西游记"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
        [[MusicManager shareInstance] playCurrentMusic];

        
        _play.tag = 1;
        
    }
    else if(_play.tag == 0&&[_name.text isEqualToString:@"情感发展"]){
        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
        [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
    
        
        [[MusicManager shareInstance] playCurrentMusic];

        
        _play.tag = 1;
        
    }else{
        
        // [self stops];
    }
    
}

- (void)stops{
    
    if ([self.delegate respondsToSelector:@selector(cellStopAnimation)]) {
        [self.delegate cellStopAnimation];
    }
    
//    [[PlayerManager defaultManager]stopPlay];
    [[MusicManager shareInstance]stopCurrentMusic];
    [self stopAnimation];
    [self runstop];
    [_musicView setHidden:YES];
    _play.tag = 0;
    _play.selected = NO;
    
}

// 扩音器 /(ㄒoㄒ)/~~
-(void)initRecordSession
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    //  录音退出后台
    if(audioSession == nil)
        NSLog(@"Error creating session: %@", [err description]);
    [audioSession setActive:YES error:nil];
    
}

- (void)runStar{
    
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"chat_receiver_audio_playing001"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing002"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing003"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing004"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing005"],nil];
    _musicView.animationImages = gifArray; //动画图片数组
    _musicView.animationDuration = 2; //执行一次完整动画所需的时长
    _musicView.animationRepeatCount = 500;  //动画重复次数
    [_musicView startAnimating];
    
}

- (void)runstop{
    
    [_musicView stopAnimating];
    
}

-(void) startAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 2;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber  numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    [_imageView .layer addAnimation:animation forKey:@"transform.rotation.z"];
}


- (void)stopAnimation{
    
    [_imageView.layer removeAnimationForKey:@"transform.rotation.z"];
    
}



- (void)payRMB{
    
    NSLog(@"点击了 打赏1");
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打赏5币" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    NSLog(@"点击了 打赏");
    [alertView show];
    
}

- (void)nextPlayMusic{
    if (_play.tag == 1) {
        
//        [[PlayerManager defaultManager]stopPlay];
//        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
          [[MusicManager shareInstance]stopCurrentMusic];
           [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
         [[MusicManager shareInstance] playCurrentMusic];
        [_play setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
        [self startAnimation];
        [self runStar];
    }
}


- (void)backPlayMusic{
    if (_play.tag ==1 ) {
        
//        [[PlayerManager defaultManager]stopPlay];
//        [[PlayerManager defaultManager] playingMusic:@"十二属相歌.mp3"];
        [[MusicManager shareInstance]stopCurrentMusic];
           [[MusicManager shareInstance] setCurrentMusic:[[DataManager shareInstance] getMusicData][1]];
         [[MusicManager shareInstance] playCurrentMusic];
        [_play setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
        [self startAnimation];
        [self runStar];
    }
}


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

@end
