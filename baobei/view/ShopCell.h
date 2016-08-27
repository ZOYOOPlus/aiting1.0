//
//  ShopCell.h
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"
@class ShopPhotoModel;
#define kImageProportion 0.7

@interface ShopCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *sales;
@property (nonatomic, strong) UILabel *goodsName;

@property (nonatomic, strong) ShopPhotoModel *shopPhotoMode;

@end

