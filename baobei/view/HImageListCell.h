//
//  HImageListCell.h
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//
/**
 *  一张图片的cell
 */

#import <UIKit/UIKit.h>
#import "HCommon.h"
#import "BookPhotoModel.h"

@interface HImageListCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) NSString *imgStr;

@property (nonatomic, copy, readonly) NSString *playFile;

@property (nonatomic,strong)BookPhotoModel *yinghuoPhotoModel;

@end
