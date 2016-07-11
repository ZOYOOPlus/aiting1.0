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

@interface ListenCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, assign) BOOL isPlay;

@property (nonatomic, strong) ListenData *data;

@end
