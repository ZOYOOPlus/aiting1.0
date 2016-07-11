//
//  HActivityHeadView.m
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HActivityHeadView.h"
#import "HWordListCell.h"

static NSString *cellID = @"HWordListCell";

@interface HActivityHeadView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HActivityHeadView

// 三个Label 一个 + 号

- (UICollectionViewLayout *)getLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(80, self.frame.size.height);
    
    return layout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFE44D"];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self getLayout]];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HWordListCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HWordListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.title.text = self.dataSource[indexPath.row];
    return cell;
}

-  (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

@end
