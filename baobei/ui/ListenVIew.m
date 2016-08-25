//
//  ListenVIew.m
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ListenVIew.h"
#import "ListenCell.h"
@interface ListenCell()
@end
@implementation ListenVIew


//- (void)players{
//    
//    [self startAnimation];
//    if(_play.tag == 0){
//        [self plays];
//        
//    }else
//        
//    {
//        [self stops];
//    }
//}


//- (void)URLplays{
//    
//    NSString *urlStr = @"http://audio.xmcdn.com/group16/M06/6E/3E/wKgDalc7NPfDsjEyAF5JwQWHKB0355.m4a";
//    NSURL *url = [[NSURL alloc]initWithString:urlStr];
//    NSData * audioData = [NSData dataWithContentsOfURL:url];
//    
//    //将数据保存到本地指定位置
//    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.m4a", docDirPath , @"temp"];
//    [audioData writeToFile:filePath atomically:YES];
//    
//    //播放本地音乐
//    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//    [self.player prepareToPlay];
//    [self initRecordSession];
//    
//    [self.player play];
//    
//    [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
//    _play.selected = YES;
//    _play.tag = 1;
//    
//}

//- (void)plays{
//    
//    [_musicView setHidden:NO];
//    
//    if([_name.text isEqualToString:@"哄睡"]){
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"ABC.mp3" withExtension:nil];
//        _player =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        
//        [self.player prepareToPlay];
//        [self initRecordSession];
//        
//        
//        [self.player play];
//        [self  runStar];
//        
//        [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateSelected];
//        _play.selected = YES;
//        _play.tag = 1;
//        
//    }else if([_name.text isEqualToString:@"80后"]){
//        
//        NSLog(@"%@",self.player);
//        
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"2015.mp3" withExtension:nil];
//        
//        self.player =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        [self.player prepareToPlay];
//        [self initRecordSession];
//        
//        [self.player play];
//        [self  runStar];
//        [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
//        _play.selected = YES;
//        _play.tag = 1;
//        
//    }else if([_name.text isEqualToString:@"托马斯"]){
//        
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"十二属相歌.mp3" withExtension:nil];
//        _player =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        [self.player prepareToPlay];
//        [self initRecordSession];
//        
//        [self.player play];
//        [self  runStar];
//        [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
//        _play.selected = YES;
//        _play.tag = 1;
//    }else if([_name.text isEqualToString:@"西游记"]){
//        
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"五指歌.mp3" withExtension:nil];
//        _player =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        [self.player prepareToPlay];
//        [self initRecordSession];
//        
//        [self.player play];
//        [self  runStar];
//        [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
//        _play.selected = YES;
//        _play.tag = 1;
//        
//    }else{
//        
//        [_player stop];
//        [_play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
//        [self stopAnimation];
//        
//    }
//}
//
//- (void)stops{
//    [self stopAnimation];
//    [_play setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
//    _play.tag = 0;
//    _play.selected = NO;
//    [self.player pause];
//    //  [self.player stop];
//    
//    // 将时间归零
//    //  self.player.currentTime = 0;
//    [_musicView setHidden:YES];
//    
//}
//
//// 扩音器 /(ㄒoㄒ)/~~
//-(void)initRecordSession
//{
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    NSError *err = nil;
//    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
//    //  录音退出后台
//    if(audioSession == nil)
//        NSLog(@"Error creating session: %@", [err description]);
//    [audioSession setActive:YES error:nil];
//}
//
//- (void)runStar{
//    
//    
//    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"chat_receiver_audio_playing000"],
//                         [UIImage imageNamed:@"chat_receiver_audio_playing001"],
//                         [UIImage imageNamed:@"chat_receiver_audio_playing002"],
//                         [UIImage imageNamed:@"chat_receiver_audio_playing003"],
//                         [UIImage imageNamed:@"chat_receiver_audio_playing004"],nil];
//    _musicView.animationImages = gifArray; //动画图片数组
//    _musicView.animationDuration = 2; //执行一次完整动画所需的时长
//    _musicView.animationRepeatCount = 500;  //动画重复次数
//    [_musicView startAnimating];
//    
//}
//
//-(void) startAnimation
//{
//    
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    
//    animation.duration = 2;
//    animation.repeatCount = MAXFLOAT;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.fromValue = [NSNumber  numberWithFloat:0.0];
//    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
//    [_imageView .layer addAnimation:animation forKey:@"transform.rotation.z"];
//    
//    
//    
//}
//
//- (void)stopAnimation{
//    
//    [_imageView.layer removeAnimationForKey:@"transform.rotation.z"];
//    
//}
//
//
//- (void)payRMB{
//    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打赏5元" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
//    
//}

//- (void)setSelected:(BOOL)selected{
//    [super setSelected:selected];
//}
//- (void)prepareForReuse {
//    [super prepareForReuse];
//    //控件或控件内容置空
//}

@end
