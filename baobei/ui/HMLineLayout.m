//
//  HMLineLayout.m
//  01_自定义UICollectionView布局LineLayout
//
//  Created by apple on 20/6/8.
//  Copyright (c) 2020年 apple. All rights reserved.
//

#import "HMLineLayout.h"

@implementation HMLineLayout

/**
 *  最好别在init方法中初始化布局
 */
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

/**
 *  准备布局
 */
- (void)prepareLayout {
    // 必须调用父类（父类也有一些准备操作）
    [super prepareLayout];
    
    // 设置滚动方向（只有流水布局才有这个属性）
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置cell的尺寸
    CGFloat itemWH = self.collectionView.frame.size.height-20 ;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    
    // 内边距的方向
    // 1     2     3    4     UIEdgeInsets insets = {top, left, bottom, right};
    self.sectionInset = UIEdgeInsetsMake(0, 5, 0, 25);
    
}

/**
 *  返回CollectionView上面所有元素的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSLog(@"layoutAttributesForElementsInRect");

    // 调用父类方法拿到默认的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获得CollectionView中点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 在默认布局属性的基础上进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
//        // 计算cell中点x值到CollectionView中点x值的距离
//        CGFloat delta = ABS(attrs.center.x - centerX);
//        
//        // 根据距离计算缩放比例（成反比）
//        CGFloat scale = 1 - delta / (self.collectionView.frame.size.width + self.itemSize.width);
        attrs.transform = CGAffineTransformMakeScale(1, 1);
    }
    
    return array;
}

/**
 *  当CollectionView的bounds发生改变的时候是否刷新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 *  targetContentOffset：CollectionView最终的偏移量
 *  proposedContentOffset：CollectionView预期的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 计算最终的可见范围
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    // 取得cell的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算CollectionView中线的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.1;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat delta = attrs.center.x - centerX;
        
        if (ABS(delta) <= ABS(minDelta)) {
            minDelta = delta;
        }
    }

    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}

@end
