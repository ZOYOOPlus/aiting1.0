//
//  HCameraVC.h
//  baobei
//
//  Created by 贺少虎 on 16/4/26.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "HCommon.h"

@class FastttCapturedImage;
@protocol ConfirmControllerDelegate;
@interface HCameraVC : UIViewController
@property (nonatomic, weak) id <ConfirmControllerDelegate> delegate;
@property (nonatomic, strong) FastttCapturedImage *capturedImage;
@property (nonatomic, assign) BOOL imagesReady;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic,strong)  SDCycleScrollView *footview;

@end

@protocol ConfirmControllerDelegate <NSObject>
- (void)dismissConfirmController:(HCameraVC *)controller;
@end
