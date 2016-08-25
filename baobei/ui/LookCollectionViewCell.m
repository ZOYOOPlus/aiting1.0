//
//  LookCollectionViewCell.m
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LookCollectionViewCell.h"
#import "LookPhotoModel.h"
#import <MediaPlayer/MediaPlayer.h>
 static UIViewController *superVC;

@interface LookCollectionViewCell ()<UIWebViewDelegate>

@property (nonatomic, strong) MPMoviePlayerController *mpC;
@property ( nonatomic,strong) WKWebView *MP4webView;
@end

@implementation LookCollectionViewCell

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
        
        //[self.contentView addSubview:self.VideoPlayer.view];
        
//        [self.contentView addSubview:_webview.view];
        // 去掉黑屏 
        self.contentView.backgroundColor = [UIColor whiteColor];
      //  [self.contentView addSubview:self.MP4webView];
        [self.contentView addSubview:self.Lookimages];
        [self.contentView addSubview:self.LooktitleLabel];
        //[self.contentView addSubview:self.LookPlay];
       
        
    }
    return self;
}

//- (void)setShopPhotoMode:(ShopPhotoModel *)shopPhotoMode {
//    _shopPhotoMode = shopPhotoMode;
//    self.price.text = shopPhotoMode.GP_Price;
//    self.sales.text = shopPhotoMode.GP_Sell;
//    self.address.text = shopPhotoMode.GP_Address;
//    self.goodsName.text = shopPhotoMode.GP_Name;
//    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shopPhotoMode.Photos]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
//}



- (void)setLookPhotoModel:(LookPhotoModel *)LookPhotoModel{

        _LookPhotoModel = LookPhotoModel;
        self.LooktitleLabel.text= LookPhotoModel.Look_title;
        [self.Lookimages sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",LookPhotoModel.LookPhoto]] placeholderImage:[UIImage imageNamed:@"head"]];

}


- (WKWebView *)MP4webView{
    
    if (!_MP4webView) {
        _MP4webView = [[WKWebView alloc]init];
    }
    return _MP4webView;
}
//- (HWebView *)webview{
//
//    if (!_webview) {
//        _webview = [[HWebView alloc]init];
//    }
//    return _webview;
//}

- (UIImageView *)Lookimages{
    if (!_Lookimages) {
        _Lookimages = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    _Lookimages.alpha = 0.8;
    return _Lookimages;
}

//- (AVPlayerViewController  *)VideoPlayer{
//    
//    if (!_VideoPlayer) {
//        _VideoPlayer = [[AVPlayerViewController alloc]init];
//        //_VideoPlayer.view.backgroundColor = [UIColor yellowColor];
//        
//        _VideoPlayer.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
//        _session = [AVAudioSession sharedInstance];
//        [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
//        
//      
//        _VideoPlayer = [[AVPlayerViewController alloc] init];
//        _VideoPlayer.player = _player;
//        _VideoPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
//        _VideoPlayer.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
//        _VideoPlayer.showsPlaybackControls = true;
////        NSURL *url = [[NSBundle mainBundle ]URLForResource:@"Cupid_高清.mp4" withExtension:nil];
////        _player = [AVPlayer playerWithURL:url];
////        [_VideoPlayer.player play];
////        NSURL *url = [[NSBundle mainBundle ]URLForResource:@"Cupid_高清.mp4" withExtension:nil];
////        
//        //_player = [AVPlayer playerWithURL:url];
////          _player = [AVPlayer playerWithURL:[NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
////            [_VideoPlayer.player play];    //自动播放
////
////        NSURL *audioUrl = [[NSBundle mainBundle] URLForResource:@"Cupid.mp4" withExtension:nil];
////        _player = [AVPlayer playerWithURL:audioUrl];
////        [_VideoPlayer.player play];
//        
//        
//    }
//    return _VideoPlayer;
//    
//}

- (UILabel *)LooktitleLabel{
    
    if (!_LooktitleLabel) {
        _LooktitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        //_LooktitleLabel.text= @"疯狂动物城";
        _LooktitleLabel.textColor= [UIColor whiteColor];
        _LooktitleLabel.textAlignment = NSTextAlignmentCenter;
        //_LooktitleLabel.backgroundColor = [UIColor blackColor];
    }
    return _LooktitleLabel;
}

//- (UIButton *)LookPlay{
//
//    if (!_LookPlay) {
//        _LookPlay = [[UIButton alloc]initWithFrame:CGRectZero];
//        [_LookPlay setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
//        [_LookPlay addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//
//    return _LookPlay;
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [_VideoPlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView.mas_centerX);
//        make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
//        make.width.equalTo(self.contentView.mas_width);
//        make.height.equalTo(self.contentView.mas_height);
//    }];
    
        [_MP4webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.width.equalTo(self.contentView.mas_width);
            make.height.equalTo(self.contentView.mas_height).offset(-1);
            }];
    
    [self.Lookimages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height).offset(-1);
    }];
 
    [self.LooktitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
//    [self.LookPlay mas_makeConstraints:^(MASConstraintMaker *make) {
//       // make.centerX.equalTo(fDeviceWidth/2);
//        make.left.equalTo(self.contentView.mas_left).offset(fDeviceWidth/2-40);
//        make.top.equalTo(self.contentView.mas_top).offset(self.contentView.height/2-40);
//        make.size.mas_equalTo(CGSizeMake(80, 80));
//    }];
    
}


- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark  播放网络的 需要请求下载完毕后才能播放   或流媒体
#pragma mark  播放时 Lookimages 的透明度设为 0
- (void)playVideo {
    
    
//    [UIView animateWithDuration:1.5
//     
//                     animations:^(void) {_Lookimages.alpha = 1;[NSThread sleepForTimeInterval:1.0];}
//    
//     ];
    
    [UIView animateWithDuration:2.0
     
                     animations:^(void) {_Lookimages.alpha = 1;}];
    
    
//    [UIView animateWithDuration:2.0
//     
//                     animations:^(void) {_LookPlay.alpha = 0;}];
    

   
    [self playVideoURL];
#pragma mark  webView 不能控制播放的尺寸
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
//    [self.contentView addSubview:webView];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [webView loadRequest:request];
    
    
    #pragma mark  webView 不能控制播放的尺寸下载完 才播放
//    _webview = [[HWebView alloc]initWithURL:[NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
//    _webview.view.frame = self.contentView.bounds;
//    [self.contentView addSubview:_webview.view];
    

  //  MBProgressHUD *pro = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    
    
//              _player = [AVPlayer playerWithURL:[NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
//              //自动播放
////    
 //   NSString *audioPath = [[NSBundle mainBundle]pathForResource:@"Cupid.mp4" ofType:nil];
    //NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
    
//    NSURL *audioUrl = [[NSBundle mainBundle] URLForResource:@"Cupid.mp4" withExtension:nil];
//    _player = [AVPlayer playerWithURL:audioUrl];
//
//    [_VideoPlayer.player play];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    
//    NSURL *url2 = [NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
//    [self.MP4webView loadRequest:request];
//    self.MP4webView.delegate = self;
    
    
//        NSURL *url = [NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //[self.MP4webView loadRequest:request];
    
       // self.MP4webView.delegate = self;
    
}

- (void )moviePlayerController
{
    // 不带View的播放器的控制器 --> 需要强引用, 设置frame, 添加到view上, 开始播放
    //1. 获取URL地址
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Cupid_高清.mp4" withExtension:nil];
    //  _MP4webView.automaticallyAdjustsScrollViewInsets = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.MP4webView loadRequest:request];
    
  //  self.MP4webView.delegate = self;
    
    
    //2. 创建不带View的播放器
    self.mpC = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    //3. 设置view.frame
    self.mpC.view.frame = self.MP4webView.frame;
    
    //4. 添加到view上
    [self.MP4webView addSubview:self.mpC.view];
    
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

- (void)playVideoURL{

//
//    HWebView *webViewlook = [[HWebView alloc]initWithURL:[NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"]];
//    
//    superVC = [self viewController:self];
    
   // [superVC.navigationController pushViewController:webViewlook animated:YES];
   // [superVC.navigationController pushViewController:webViewlook animated:YES];
   //  [superVC presentViewController:webViewlook animated:YES completion:^{
         
  //   }];
//    [superVC.navigationController presentViewController:webViewlook animated:YES completion:^{
//        [superVC.navigationController pushViewController:webViewlook animated:YES];
//    }];
}



@end
