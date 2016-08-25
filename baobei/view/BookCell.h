//
//  BookCell.h
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"
#import "BookPhotoModel.h"
@interface BookCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property  (nonatomic,strong) UILabel  *exchag;
@property (nonatomic, strong)UIButton *exchangeBtn; // 兑换
@property  (nonatomic,strong)UIButton  *downBtn; // 下载
@property (nonatomic,strong)BookPhotoModel *bookPhotoModel;

@end
