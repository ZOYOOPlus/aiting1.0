//
//  VideoVC.m
//  jyt
//
//  Created by 贺少虎 on 16/6/6.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "VideoVC.h"

@interface VideoVC ()<PlayerKitContainerDelegate>

@property (nonatomic,strong) PlayerKitContainer  *playeContainer;

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.title = @"视频测试";
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUp{
    [self.view addSubview:self.playeContainer];

}

#pragma mark - Propertys

- (PlayerKitContainer *)playeContainer {
    if (!_playeContainer) {
        _playeContainer = [[PlayerKitContainer alloc] init];
        _playeContainer.delegate = self;
        _playeContainer.playbackLoops = YES;
        _playeContainer.mediaPath = self.video.mp4URL;
        [_playeContainer buildInterface];
    }
    return _playeContainer;
}

- (void)playerKitContainer:(PlayerKitContainer *)playerContainer willAnimationWithType:(PlayerKitAnimationType)animationType {
//    self.backButton.hidden = (animationType != PlayerKitAnimationTypeNone);
    BOOL hide = (animationType != PlayerKitAnimationTypeNone);
//    [[UIApplication sharedApplication] setStatusBarHidden:hide withAnimation:UIStatusBarAnimationSlide];
    [super.navigationController setNavigationBarHidden:hide animated:TRUE];
}

@end
