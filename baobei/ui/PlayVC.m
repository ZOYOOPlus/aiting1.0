//
//  PlayVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "PlayVC.h"
#import "HCommon.h"
#import <MediaPlayer/MediaPlayer.h>
//#import "HWebView.h"
@interface PlayVC ()
@property (nonatomic,strong) MPMoviePlayerController *mpC;
@property (nonatomic, nonatomic)UIWebView *MP4webView;
@property (nonatomic,strong)UIButton *playbtnView;
@property  (nonatomic,strong)UIButton *playbtn;
@end

@implementation PlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSURL *url2 = [NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    [self.MP4webView loadRequest:request];
    self.MP4webView.delegate = self;

}
- (void)setupUI{
    
    _mpC = [[MPMoviePlayerController alloc]init];
    _mpC.view.frame = CGRectMake(0, 0, 430, 280);
    [self.view addSubview:_mpC];
    
    _playbtnView = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_playbtnView setTitle:@"播放" forState:UIControlStateNormal];
    [_playbtnView setTintColor:[UIColor blueColor]];
    _playbtnView.frame = CGRectMake(0, 280, 200, 50);
    [_playbtnView addTarget:self action:@selector(moviePlayerController) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:_playbtnView];
    
    _playbtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playbtn setTitle:@"播放" forState:UIControlStateNormal];
    [_playbtn setTintColor:[UIColor blueColor]];
    _playbtn.frame = CGRectMake(200, 280, 200, 50);
    [_playbtn addTarget:self action:@selector(moviePlayerController2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playbtn];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request.URL);    
    return YES;
}
#pragma mark 通知绑定的方法
- (void)moviePlayerPlaybackDidFinishNotification:(NSNotification *)notification
{
    /**
     MPMovieFinishReasonPlaybackEnded,  播放结束
     MPMovieFinishReasonPlaybackError,  播放错误
     MPMovieFinishReasonUserExited      退出播放
     */
    
    //1. 获取通知结束的状态
    NSInteger movieFinishKey = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    
    //2. 根据状态不同来自行填写逻辑代码
    switch (movieFinishKey) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"播放结束");
            
            // 进行视频切换 需要两步
            
            //1. 要想换视频, 就需要更换地址
            self.mpC.contentURL = [[NSBundle mainBundle] URLForResource:@"Cupid_高清.mp4" withExtension:nil];
            
            //2. 调用play方法
            [self.mpC play];
            
            break;
            
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"播放错误");
            break;
            
        case MPMovieFinishReasonUserExited:
            NSLog(@"退出播放");
            
            // 如果是不带view的播放器, 那么播放完毕(退出/错误/结束)都应该退出
            [self.mpC.view removeFromSuperview];
            break;
            
        default:
            break;
    }
    
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moviePlayerViewController2:(id)sender {
    // 带View的播放器的控制器
    //1. 获取URL地址
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d" withExtension:nil];
    
    //2. 创建带View的播放器
    MPMoviePlayerViewController *mpVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    //3. 模态视图弹出 --> 模态视图的切换应该在View完全展示之后进行
    [self presentViewController:mpVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moviePlayerController
{
    // 不带View的播放器的控制器 --> 需要强引用, 设置frame, 添加到view上, 开始播放
    //1. 获取URL地址
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Cupid_高清.mp4" withExtension:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.MP4webView loadRequest:request];
    
    self.MP4webView.delegate = self;
    

    //2. 创建不带View的播放器
    self.mpC = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    //3. 设置view.frame
    self.mpC.view.frame = CGRectMake(0, 0, 430, 280);
    
    //4. 添加到view上
    [self.view addSubview:self.mpC.view];
    
    //5. 准备播放 --> 规范写法, 要写上. 调用play方法时, 会自动调用此方法
    [self.mpC prepareToPlay];
    
    //6. 开始播放
    [self.mpC play];
    
    //7. 控制模式
    self.mpC.controlStyle = MPMovieControlStyleFullscreen;
    
    /**
     MPMovieControlStyleNone,       // No controls
     MPMovieControlStyleEmbedded,   // 嵌入式的控制 -- 默认
     MPMovieControlStyleFullscreen, // 全屏时的控制样式
     */
    
    
    
}
@end
