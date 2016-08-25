//
//  LookCollectionViewCell.h
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HCommon.h"
#import "HWebView.h"
@class LookPhotoModel;
@interface LookCollectionViewCell : UICollectionViewCell
{
    AVPlayerViewController      *_VideoPlayer;
    AVPlayer                    *_player;
    AVAudioSession              *_session;
    NSString                    *_urlString;
}

//@property (nonatomic,strong) AVPlayerViewController *VideoPlayer;
@property (nonatomic,strong) UIImageView *Lookimages;
@property (nonatomic,strong) UILabel  *LooktitleLabel;
@property (nonatomic,strong) UIButton *LookPlay;
@property (nonatomic,strong) UIButton *lookStop;

@property (nonatomic, strong) LookPhotoModel *LookPhotoModel;

@end
