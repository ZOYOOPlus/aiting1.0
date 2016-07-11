//
//  HomeVC.h
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"

static CGFloat kBannerHeight = 150.0f;
static CGFloat kHeadHeight = 30.f;

@interface HomeVC : BaseVC

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView * collectionView;

@end
