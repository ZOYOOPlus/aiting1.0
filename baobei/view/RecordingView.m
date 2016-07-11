//
//  RecordingView.m
//  baobei
//
//  Created by 贺少虎 on 16/5/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "RecordingView.h"
#import "HCommon.h"
#import "HImageListCell.h"
#define kRecordAudioFile @"myRecord.caf"
#define IMG_COUNT  8
static  NSString *cellID = @"IMG";

@interface RecordingView ()<UICollectionViewDelegate,UICollectionViewDataSource,AVAudioRecorderDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UIButton *recordButton;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）


@end

@implementation RecordingView


+ (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat itemWidth = [[self class] contentHeight];
    flowLayout.itemSize = CGSizeMake(300,188);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, (screenWidth - 300)/2, 0, (screenWidth - 300)/2);
    flowLayout.minimumLineSpacing = (screenWidth - 300);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addRecordButton];

        [self addSubview:self.collectionView];
        [self addSubview:self.title];
        [self setAudioSession];
      //  [self addSpeakPhoto];
       
    }
    return self;
}

- (void)addRecordButton{
    _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recordButton setImage:[UIImage imageNamed:@"lv.png"] forState:UIControlStateNormal];
    [_recordButton setImage:[UIImage imageNamed:@"lv2.png"] forState:UIControlStateHighlighted];
    [_recordButton addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_recordButton];
    

}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,188+20 ) collectionViewLayout:[[self class] getFlowLayout]];
        [_collectionView registerClass:[HImageListCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"看图讲故事";
        _title.textColor = [UIColor grayColor];
        _title.font = [UIFont systemFontOfSize:18];
    }
    return _title;
}

-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        [_audioPlayer  play];
        NSLog(@"播放完成");
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-60);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        make.height.equalTo(self.mas_width).multipliedBy(0.3);
    }];
    
    [self.title sizeToFit];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
    }];
    
}


#pragma mark 录音

-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    
    // [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    //外音
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [audioSession setActive:YES error:nil];
//     [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}



-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}


/**
 leancloud 加载图片
 
 */
- (void)addSpeakPhoto{
    AVQuery  *query = [AVQuery queryWithClassName:AT_SPEAKPHOTO];
    // 升序
    //[query addAscendingOrder:@"order"];
    // 降序
      [query addDescendingOrder:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==NULL && objects!= NULL && objects.count > 0) {
            
            
            AVFile* imageFile1 = [objects[0] objectForKey:@"SPoto"];
            AVFile* imageFile2 = [objects[1] objectForKey:@"SPoto"];
            AVFile* imageFile3 = [objects[2] objectForKey:@"SPoto"];
            AVFile* imageFile4 = [objects[3] objectForKey:@"SPoto"];
            AVFile* imageFile5 = [objects[4] objectForKey:@"SPoto"];
            AVFile* imageFile6 = [objects[5] objectForKey:@"SPoto"];
            AVFile* imageFile7 = [objects[6] objectForKey:@"SPoto"];
            AVFile* imageFile8 = [objects[7] objectForKey:@"SPoto"];
        
         //    NSArray *array = @[imageFile1,imageFile2 ,imageFile3 ,imageFile4 ,imageFile5 ,imageFile6 ,imageFile7,imageFile8 ];
             NSArray *array = @[[imageFile1 url],[imageFile2 url],[imageFile3 url],[imageFile4 url],[imageFile5 url],[imageFile6 url],[imageFile7 url],[imageFile8 url]];
            [_collectionView registerClass:[HImageListCell class] forCellWithReuseIdentifier:cellID];
            SDCycleScrollView *SpeakPhoto = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width,188+20 ) imageNamesGroup:array];
            SpeakPhoto.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
            SpeakPhoto.delegate = self;
            
            [self.collectionView addSubview:SpeakPhoto];
        }
    }];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
   NSString *imgStr = [NSString stringWithFormat:@"00%zd.jpg", indexPath.row+1];
    cell.imageView.image = [UIImage imageNamed:imgStr];
    
 
    DLog(@"testest");
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return IMG_COUNT;
}

- (void)recordClick:(id)sender{
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        _recordButton.selected = YES;
        [self audioRecorderDidFinishRecording:self.audioRecorder successfully:YES];
        // self.timer.fireDate=[NSDate distantPast];
    }else{
        _recordButton.selected = NO;
        [self.audioRecorder stop];

    }
}



#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (![self.audioPlayer isPlaying]) {
        
        
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [self.audioPlayer play];
   
    }
    NSLog(@"录音完成!");
}



@end
