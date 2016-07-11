//
//  RowAdsView.h
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kRowDisplayNum = 4.0;
static CGFloat kAspectRatio = 1.0;
static CGFloat kADsHeight = 150;
@protocol RowAdsViewDelegate;

@interface RowAdsView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) id <RowAdsViewDelegate> adsDelegate;
@property (nonatomic,strong) NSMutableArray *adsArray;

- (instancetype)initWithPostionY:(CGFloat)y;
+ (CGFloat)contentHeight;

@end

@protocol RowAdsViewDelegate <NSObject>

- (void)selectAdsAtIndex:(NSInteger)index;

@end
