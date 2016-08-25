//
//  RowAdsView.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "RowAdsView.h"
#import "RowAdsCell.h"
#import "AdsModel.h"

static NSString *cellID = @"adsCell";

@implementation RowAdsView

+ (CGFloat)contentHeight{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return screenWidth/kRowDisplayNum * kAspectRatio + 20;}

+ (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat itemWidth = [[self class] contentHeight];
    flowLayout.itemSize = CGSizeMake(screenWidth/kRowDisplayNum + 17, [[self class] contentHeight] -22);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (instancetype)initWithPostionY:(CGFloat)y;
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:CGRectMake(0, y, screenWidth, [[self class] contentHeight]) collectionViewLayout:[[self class] getFlowLayout]];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.backgroundColor = [UIColor clearColor];
    [self registerClass:[RowAdsCell class] forCellWithReuseIdentifier:cellID];
    self.showsHorizontalScrollIndicator = NO;
    self.dataSource = self;
    self.delegate = self;
}

-  (void)setAdsArray:(NSMutableArray *)adsArray{
    if (_adsArray == adsArray) {
        return;
    }
    _adsArray = adsArray;
    if (_adsArray.count < 5) {
        if ([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout  class]]) {
//            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
//            CGFloat len = flowLayout.itemSize.width * _adsArray.count +  _adsArray.count *10;
//            flowLayout.sectionInset = UIEdgeInsetsMake(10, 40, 10, 50);
            
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.adsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RowAdsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    AdsModel *ads = self.adsArray[indexPath.row];
    cell.ads = ads;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.adsDelegate && [self.adsDelegate respondsToSelector:@selector(selectAdsAtIndex:)]) {
        [self.adsDelegate selectAdsAtIndex:indexPath.row];
    }
}



@end
