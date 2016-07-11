//
//  HCameraVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/26.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HCameraVC.h"
#import <FastttCamera/FastttCamera.h>
#import "HCommon.h"

#import <Masonry.h>

@interface HCameraVC () <FastttCameraDelegate>

@property (nonatomic,strong) FastttCamera * fastCamera;
@property (nonatomic,strong) UIImageView *lineView;
//@property (nonatomic,strong) AVCaptureSession *session;
//@property (nonatomic,strong) AVCaptureStillImageOutput *stillImageOutput;
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation HCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _fastCamera = [[FastttCamera alloc] init];
    _fastCamera.delegate = self;
    [self fastttAddChildViewController:self.fastCamera];
    self.fastCamera.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
//    UIView *mask = [[UIView alloc] initWithFrame:self.fastCamera.view.frame];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_banner_1"]];
//    [mask addSubview:imageView];
//    imageView.frame = CGRectMake(10, 10, 30, 30);
//    
//    [self.fastCamera.view addSubview:mask];
//    [mask addSubview:imageView];
    
    
    _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"faguang.png"]];
    _lineView.frame = CGRectMake(0, -30, self.view.frame.size.width, 30);
    _lineView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_lineView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"拍照" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"update/Camera.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"update/Camera.png"] forState:UIControlStateHighlighted];

    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.size.mas_equalTo(CGSizeMake(96, 96));
    }];
    
    [button addTarget:self action:@selector(clickTake) forControlEvents:UIControlEventTouchUpInside];
    
    
//    //
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [button setTitle:@"拍照" forState:UIControlStateNormal];
//    [button2 setImage:[UIImage imageNamed:@"update/Camera2.png"] forState:UIControlStateNormal];
//    [button2 setImage:[UIImage imageNamed:@"update/Camera2.png"] forState:UIControlStateHighlighted];
//    
//    [self.view addSubview:button2];
//    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX).offset(50);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
//        make.size.mas_equalTo(CGSizeMake(96, 96));
//    }];
    
    


    [self didStopAnimation];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didStopAnimation{
    _lineView.frame = CGRectMake(0, -30, self.view.frame.size.width, 30);

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    //    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    _lineView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 30);
    
    [UIView commitAnimations];
}

- (void)clickButton{
    if (_fastCamera.cameraDevice == FastttCameraDeviceFront) {
        _fastCamera.cameraDevice = FastttCameraDeviceRear;
    }else{
        _fastCamera.cameraDevice = FastttCameraDeviceFront;
    }
}

- (void)clickTake{
    [_fastCamera takePicture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)cameraController:(id<FastttCameraInterface>)cameraController didFinishCapturingImage:(FastttCapturedImage *)capturedImage
{
    NSLog(@"A photo was taken");
}

- (void)cameraController:(id<FastttCameraInterface>)cameraController didFinishNormalizingCapturedImage:(FastttCapturedImage *)capturedImage
{
    NSLog(@"Photos are ready");
    
}



@end
