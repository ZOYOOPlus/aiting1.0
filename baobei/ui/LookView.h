//
//  LookView.h
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVKit/AVKit.h>
#import "HCommon.h"
#import "BaseVC.h"


@interface LookView : UIView

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UIImage *lookimage;


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;

@end
