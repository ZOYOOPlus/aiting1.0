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
#import "BookVC.h"
#import "BookDao.h"
#import "BookPhotoModel.h"
#import "LoginVC.h"
#define YINGHUOQIBING1  0
#define YINGHUOQIBING2  1
#define YINGHUOQIBING3  2
#define YINGHUOQIBING4  3
#define YINGHUOQIBING5  4
#define YINGHUOQIBING6  5

#define kRecordAudioFile @"myRecord.caf"
#define IMG_COUNT  8
#define currentFileName   @"/var/mobile/Containers/Data/Application/F7A003A9-D7D6-4763-920B-1B217AFA6435/Documents/"
static  NSString *cellID = @"IMG";

@interface RecordingView ()<UICollectionViewDelegate,UICollectionViewDataSource,AVAudioRecorderDelegate,SDCycleScrollViewDelegate, AVAudioPlayerDelegate>
@property (nonatomic,strong) UILabel *title;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic,strong)UIButton *playBtn;
@property  (nonatomic,strong)UIButton *recordBtn;
@property  (nonatomic,strong) UIButton *bookSlect;
@property (nonatomic,strong)AVAudioRecorder *recorder;
@property (nonatomic,strong)AVAudioPlayer *player;
@property (nonatomic,strong)NSDictionary *recorderSettingsDict;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *volumImages;
@property (nonatomic ,strong)NSURL  *someURL;
@property (nonatomic,assign)double lowPassResults;
@property (nonatomic,strong)  NSString *playName;
@property (nonatomic, assign) NSInteger selectType;
@property  (nonatomic,strong)NSMutableArray *arrMbook1;
@property  (nonatomic,strong)NSMutableArray  *arrMbook2;
@property  (nonatomic,strong)NSString *imgageFileurl;
@property  (nonatomic,strong)UIButton  *codeButton;
@property (nonatomic, strong) NSArray *yinghuophotoArray;

@property (nonatomic,assign) int  timeout;

@end

@implementation RecordingView


+ (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //    CGFloat itemWidth = [[self class] contentHeight];
    flowLayout.itemSize = CGSizeMake(fDeviceWidth,200);
 //   flowLayout.sectionInset = UIEdgeInsetsMake(0, (screenWidth - 356)/2, 0, (screenWidth - 356)/2);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initRecordSession];
        [self addSubview:self.collectionView];
        [self addSubview:self.title];
        [self addSubview:self.codeButton];
        self.backgroundColor = [UIColor whiteColor];
      //  [self getYIngHUOPhotoMessage];
        

       // [self  imageQueryBook1];
        //[self  imageQueryBook2];
        [self.collectionView reloadData];
        [self  setup];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(someMethod)
                                                     name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        
    }
    return self;
}

- (void)setup{
    
    
    //    // 添加状态
    //    [self addObserver:self forKeyPath:@"isRecording" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    //    [self addObserver:self forKeyPath:@"isPlaying" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
    _playBtn.tag = 0;
    _playBtn.adjustsImageWhenHighlighted = NO;
 //     [_playBtn addTarget:self action:@selector(cannle:) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:_playBtn];
    
    _recordBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    
    [_recordBtn setImage:[UIImage imageNamed:@"麦12.jpg"] forState:UIControlStateNormal];
    _recordBtn.tag = 0;
    _recordBtn.adjustsImageWhenHighlighted = NO;
    // 按下录音
    
#pragma mark      更改需求 只点击一下录音
    
    [_recordBtn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    // 点击一下停止录音
    //    [_recordBtn addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchCancel];
    
    [self addSubview:_recordBtn];
    
    //[self setup];
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
    }

    //第一种
    //初始化工作
    NSError *error;
    NSString *string=[NSString stringWithFormat:@"01%@.acc",error];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获得存储路径，
    NSString *documentDirectory = [paths objectAtIndex:0];//获得路径的第0个元素
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentDirectory stringByAppendingPathComponent:@"text"];
    //    [fileManage createDirectoryAtPath:myDirectory attributes:nil];
    [fileManage createDirectoryAtPath:myDirectory attributes:nil] ;
    _playName = [documentDirectory stringByAppendingPathComponent:string];//在第0个元素中添加txt文本
    
    
    //录音设置
    _recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                            [NSNumber numberWithInt:8000.0],AVSampleRateKey,
                            [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    
    //音量图片数组
    _volumImages = [[NSMutableArray alloc]initWithObjects:@"RecordingSignal001",@"RecordingSignal002",@"RecordingSignal003",
                    @"RecordingSignal004", @"RecordingSignal005",@"RecordingSignal006",
                    @"RecordingSignal007",@"RecordingSignal008",   nil];
    
}

#pragma mark  录音照片的frame 设置
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        if ([UIScreen mainScreen].bounds.size.width== 320){
            
             _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -35, fDeviceWidth,188+20 ) collectionViewLayout:[[self class] getFlowLayout]];
        
        }else{
            
           _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, fDeviceWidth,188+20 ) collectionViewLayout:[[self class] getFlowLayout]];
        
        }
       
        [_collectionView registerClass:[HImageListCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;       
    
}

//  dealloc
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isRecording"];
    [self removeObserver:self forKeyPath:@"isPlaying"];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)addpo{
    
    // BookVC *bVC = [[BookVC  alloc]init];
    
}

#pragma mark      --------------录音的点击方法




- (void)downAction:(id)sender {
    
     if([AVUser currentUser] != NULL){
 
    if (_recordBtn.tag == 0) {
        
        [self TimerStart];
        _recordBtn.selected = YES;
        _recordBtn.tag = 2;
        [_recordBtn  setImage:[UIImage imageNamed:@"麦o.jpg"] forState:UIControlStateNormal];
        
        //按下录音
        if ([self canRecord]) {
            
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            NSError *err = nil;
            [audioSession setCategory :AVAudioSessionCategoryRecord error:&err];
            [audioSession setActive:YES error:nil];
            
            HImageListCell *cell = [self.collectionView visibleCells].firstObject;
            
            NSError *error = nil;
            //必须真机上测试,模拟器上可能会崩溃
            _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:cell.playFile] settings:_recorderSettingsDict error:&error];
            
            if (_recorder) {
                _recorder.meteringEnabled = YES;
                [_recorder prepareToRecord];
                [_recorder record];
                
                //启动定时器
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
                
            } else
            {
                
                int errorCode = CFSwapInt32HostToBig ([error code]);
                NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
                
            }
        }
        
        
    }else{
        
        
        [self TimerStop];
        _recordBtn.selected = YES;
        _recordBtn.tag = 0;
        [_recordBtn  setImage:[UIImage imageNamed:@"麦12.jpg"] forState:UIControlStateNormal];
        
        [_recorder stop];
    }
    }else{
    
        LoginVC *LogVC = [[LoginVC alloc]init];
        [self.VC.navigationController pushViewController:LogVC animated:YES];
    
    
    }
    
}

- (void)upAction:(id)sender {
    //松开 结束录音
    
    //录音停止
    [_recorder stop];
    _recorder = nil;
    //结束定时器
    [_timer invalidate];
    _timer = nil;
    [_recorder deleteRecording];
    
    // 松开录音的时候  remove 计时器  
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)cannle:(id)sender{
    
    [_player stop];
    [_playBtn setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
    [_recorder prepareToRecord];
    
}


- (void)playAction:(id)sender {
    
   
    if (_playBtn.tag == 0) {
         _timeout = 0;
        _playBtn.tag = 1;
        [_playBtn setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
        [self upAction:nil];
        [_recordBtn setImage:[UIImage imageNamed:@"麦12.jpg"] forState:UIControlStateNormal];
        NSError *playerError;
        //NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        // 调用外音播放
        [self initRecordSession];
        //
        HImageListCell *cell = [self.collectionView visibleCells].firstObject;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:cell.playFile] error:&playerError];
        _player.delegate = self;
        
        NSLog(@"%@",_playName);
        _player.numberOfLoops=0;
        // _player =[[AVAudioPlayer alloc]initWithData:_playName error:&playerError];
        if (_player == nil)
        {
            NSLog(@"ERror creating player: %@", [playerError description]);
            
        }else{
            // 播放大音量后，不能重复创建播放器的问题是什么鬼
            //  [_playBtn setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
            NSError *err = nil;
            [_player play];
        }
    }else{
        
        [self  cannle:self];
        _playBtn.tag = 0;
        [_playBtn setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
        
    }
}
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
// 录音播放完成 的代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    _playBtn.tag = 0;
    [_playBtn setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
    
}

-(void)levelTimer:(NSTimer*)timer_
{
    //call to refresh meter values刷新平均和峰值功率,此计数是以对数刻度计量的,-160表示完全安静，0表示最大输入值
    [_recorder updateMeters];
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    _lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
    
    //    NSLog(@"Average input: %f Peak input: %f Low pass results: %f", [_recorder averagePowerForChannel:0], [_recorder peakPowerForChannel:0], _lowPassResults);
    
    NSLog(@"%d", self.recorder.isRecording);
    
}

//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    
    return bCanRecord;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"看图讲故事";
        _title.textColor = [UIColor orangeColor];
        _title.font = [UIFont systemFontOfSize:20];
    }
    return _title;
}

- (UIButton *)codeButton{

    if (!_codeButton) {
        _codeButton = [[UIButton alloc]init];
        //_codeButton.backgroundColor = [UIColor redColor];
        //[_codeButton setTintColor:[UIColor blackColor]];
        [_codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[_codeButton addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
        //[self checkCode];

    }
    return _codeButton;
}

#pragma mark   ----UI 布局
- (void)layoutSubviews{
    
    [super layoutSubviews];

    
    if ([UIScreen mainScreen].bounds.size.width== 320) {
        
        [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-100);
            make.width.equalTo(self.mas_width).multipliedBy(0.2);
            make.height.equalTo(self.mas_width).multipliedBy(0.2);
        }];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-30);
            make.bottom.equalTo(self.collectionView.mas_bottom).offset(-150);
            make.width.equalTo(self.collectionView.mas_width).multipliedBy(0.12);
            make.height.equalTo(self.collectionView.mas_height).multipliedBy(0.2);
        }];
        
        [self.title sizeToFit];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        }];
        
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(-120);
            make.top.equalTo(self.collectionView.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(130, 30));
            
        }];
        
    }else{
        [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-125);
            //        make.width.equalTo(self.mas_width).multipliedBy(0.15);
            //        make.height.equalTo(self.mas_width).multipliedBy(0.15);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-25);
            make.bottom.equalTo(self.collectionView.mas_bottom).offset(-150);
            make.width.equalTo(self.collectionView.mas_width).multipliedBy(0.1);
            make.height.equalTo(self.collectionView.mas_width).multipliedBy(0.1);
        }];
        
        [self.title sizeToFit];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        }];
        
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(-120);
            make.top.equalTo(self.collectionView.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(130, 30));
            
        }];
    }
    
}

//-(void)imageQueryBook1{
//    AVQuery* query = [AVQuery queryWithClassName:@"SpeakPhoto"];
//    [query orderByAscending:@"order"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error==NULL && objects!= NULL && objects.count > 0) {
//            _arrMbook1 = [NSMutableArray  arrayWithCapacity:42];
//            _arrMbook2 = [NSMutableArray  arrayWithCapacity:42];
//            for (int i = 0; i < objects.count; i ++) {
//                AVFile* imageFile = [objects[i] objectForKey:@"SPhotoBook"];
//                [_arrMbook1 addObject:imageFile.url];
//                //                            AVFile* imageFile1 = [objects[i] objectForKey:@"SPhotoBook2"];
//                //                            [_arrMbook2 addObject:imageFile1.url];
//                //  NSLog(@"%@",imageFile.url);
//            }
//        }
//    }];
//    [self.collectionView  reloadData];
//}

//-(void)imageQueryBook2{
//    AVQuery* query = [AVQuery queryWithClassName:@"SpeakPhoto"];
//    [query orderByAscending:@"order"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error==NULL && objects!= NULL && objects.count > 0) {
//            _arrMbook2 = [NSMutableArray  arrayWithCapacity:42];
//            for (int i = 0; i < objects.count; i ++) {
//                AVFile* imageFile1 = [objects[i] objectForKey:@"SPhotoBook2"];
//                [_arrMbook2 addObject:imageFile1.url];
//
//            }
//        }
//    }];
//    [self.collectionView  reloadData];
//}

#pragma  mark   ----加载数据源---
/*
 数据源添加
 **/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
    HImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    // 多种网络请求的 问题       录音图片的路径
//    
//           BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celllD forIndexPath:indexPath];

    if (self.VC.bookIndexPath.item == YINGHUOQIBING1) {
        cell.imageView.hidden = NO;
        
//                    NSURL *url = self.arrMbook1[indexPath.row];
//                    [cell.imageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"head.jpg"]];
       

        //    cell.yinghuoPhotoModel = self.yinghuophotoArray[indexPath.row+1];
    
            [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        NSString *imgStr = [NSString stringWithFormat:@"yinghuo1_%zd.jpg", indexPath.row+1];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.imgStr = imgStr;
    }
    
    if (self.VC.bookIndexPath.item == YINGHUOQIBING2) {
        cell.imageView.hidden = NO;
        
        NSString *imgStr = [NSString  stringWithFormat:@"yinghuo2_%zd.jpg",indexPath.row+1];
        cell.imageView.image = [UIImage  imageNamed:imgStr];
        cell.imgStr = imgStr ;
        
    }
    if (self.VC.bookIndexPath.item == YINGHUOQIBING3) {
        cell.imageView.hidden = NO;
        
        NSString *imgStr = [NSString  stringWithFormat:@"yinghuo3_%zd.jpg",indexPath.row+1];
        cell.imageView.image = [UIImage  imageNamed:imgStr];
        cell.imgStr = imgStr ;
        
    }

    if (self.VC.bookIndexPath.item == YINGHUOQIBING4) {
        
        NSString *imgStr = [NSString stringWithFormat:@"yinghuo%zd.jpg", indexPath.row+1];
        cell.imageView.image = [UIImage imageNamed:imgStr];
        cell.imgStr = imgStr;
        

    } // 若不继续判断 后续的全部自动默认
    if (self.VC.bookIndexPath.item == YINGHUOQIBING5) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }     if (self.VC.bookIndexPath.item == YINGHUOQIBING6) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 6) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 7) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 8) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 9) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 10) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 11) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 12) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    }
    if (self.VC.bookIndexPath.item == 13) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    } if (self.VC.bookIndexPath.item == 14) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
    } if (self.VC.bookIndexPath.item == 15) {
        cell.imageView.image = [UIImage imageNamed:@"head.jpg"];
        
    }
    
    DLog(@"testest");
    
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count;
    switch (self.VC.bookIndexPath.item) {
        case YINGHUOQIBING1:
            return 13;
          //  return self.yinghuophotoArray.count;
          //  NSLog(@"%lu",(unsigned long)self.yinghuophotoArray.count);
            break;
        case YINGHUOQIBING2:
            count = 4;
            break;
        case YINGHUOQIBING3:
            count = 3;
            break;
        case YINGHUOQIBING4:
            count =7;break;
        case YINGHUOQIBING5:
            count = 5;break;
        case YINGHUOQIBING6:
            count  = 2;break;
        case 6: count  = 2;break;
        case 7:
            count  = 1; case 8:
            count  = 1; case 9:
            count  = 1; case 10:
            count  = 1; case 11:
            count  = 1; case 12:
            count  = 1; case 13:
            count  = 1; case 14:
            count  = 1; case 15:
            count  = 1; case 16:
            count  = 1;
        default:
            break;
    }
    return count;
}


- (void)clickHeadButton:(id)sender{
    self.selectType = [sender tag];
    [self.collectionView reloadData];
}

- (void)setSelectType:(NSInteger)selectType{
    if (selectType == selectType) {
        return;
    }
    selectType = selectType;
    
}
#pragma mark     进入后台时 录音停止  方法没有走
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    [_recordBtn  setImage:[UIImage imageNamed:@"麦12.jpg"] forState:UIControlStateNormal];
//    [_recorder stop];
//    [self.recorder stop];
//    _timeout = 0;
//    self.recorder = nil;
//}

- (void)someMethod{
    
    [_recorder stop];
    _timeout = 0;
  
}

//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    [_recorder stop];
//    [_player  stop];
//    
//}

#pragma  mark     定时器 录一分钟
- (void)TimerStart{
    
    _codeButton.hidden = NO;
    _timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.codeButton.enabled = true;
                [_codeButton setTitle:@"请录音" forState:UIControlStateNormal];
            });
        }else{
            int seconds = _timeout ;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.codeButton.enabled = false;
                [_codeButton setTitle:strTime forState:UIControlStateNormal];
            });
            _timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)TimerStop{
    
    _timeout = 0;
    
}
#pragma mark  书本的网络请求 
//- (void)getBookPhotoMessage{
//    
//    [self.VC showProgressView:nil];
//    [BookDao getBookPhotoWithUserid:nil sucess:^(NSArray *list) {
//        [self.VC hidenProgress];
//        self.photoArray = list;
//        [self.collectionView reloadData];
//    } fail:^{
//        [self.VC hidenProgress];
//        [self.VC showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
//    }];
//    
//}
- (void)getYIngHUOPhotoMessage{
    
    [self.VC showProgressView:nil];
    [BookDao getYinghuoPhotoWithUserid:nil sucess:^(NSArray *list) {
        [self.VC hidenProgress];
        self.yinghuophotoArray = list;
    } fail:^{
        [self.VC hidenProgress];
        [self.VC showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
    }];

}


-(void)viewDidAppear:(BOOL)animated{

    [self.collectionView reloadData];
    
}
@end
