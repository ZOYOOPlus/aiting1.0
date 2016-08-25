//
//  RecordingView.h
//  baobei
//
//  Created by 贺少虎 on 16/5/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LearnVC.h"
#import "BookPhotoModel.h"
@class AEAudioController;
@protocol AccountBindingDelegate <NSObject>
- (void)jumpWebVC:(UIButton*)sender;
@end

@interface RecordingView : UIView
@property (nonatomic, weak)id<AccountBindingDelegate>delegate;
@property (nonatomic, weak) LearnVC * VC;
@property (nonatomic, assign) NSInteger trailIndex;
@property (nonatomic, strong) NSArray<NSString *> *imgs;
@property (nonatomic, strong) AEAudioController *audioController;
@property (nonatomic,strong) UICollectionView *collectionView;


-(void)imageQueryBook1;
-(void)imageQueryBook2;
@end


