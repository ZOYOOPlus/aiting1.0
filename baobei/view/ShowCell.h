//
//  ShowCell.h
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"
@class ShowPhotoModel;
#define kImageProportion 0.7

@interface ShowCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic,strong)  UILabel *zan; 


@property (nonatomic, strong) ShowPhotoModel *showPhotoMode;
@end
