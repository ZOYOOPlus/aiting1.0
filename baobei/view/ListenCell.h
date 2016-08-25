//
//  ListenCell.h
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"
#import "ListenData.h"
// 设置代理
@class ListenCell;

@protocol ListenCellDelegate <NSObject>

- (void)cellStopAnimationwithCell:(ListenCell *)cell;

- (void)cellStopAnimation;

@end



@interface ListenCell : UICollectionViewCell


@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, strong) UIButton *reward;
@property (nonatomic,strong) UIButton  *play;
@property (nonatomic, assign) BOOL isPlay;

@property (nonatomic,strong) NSURL *musicURL;
@property (nonatomic,strong) UIButton *leftNextBtn;
@property (nonatomic,strong) UIButton *rightNextBtn;
@property (nonatomic,strong) UILabel *playTime;
@property (nonatomic,strong) UILabel *playTimes;
@property (nonatomic,strong) UIImageView *musicView;
@property (nonatomic, strong) ListenData *data;

@property (nonatomic,weak)id<ListenCellDelegate>delegate;

- (void)stops;

-(void) startAnimation;

- (void)stopAnimation;

- (void)runStar;

- (void)runstop;


@end
