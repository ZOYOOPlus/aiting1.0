//
//  TesttView.m
//  baobei
//
//  Created by 贺少虎 on 16/6/18.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "TesttView.h"
#import "TestCollectionViewCell.h"

@interface TesttView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UIImage *testImage;
@end

@implementation TesttView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self.testImage = image;
    return [self initWithFrame:frame];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UICollectionViewLayout *)getViewLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 10;
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = self.frame.size.width;
    layout.itemSize = CGSizeMake(width,  width/_testImage.size.width  * _testImage.size.height);
   
    return layout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 60, fDeviceWidth, self.bounds.size.width+70+64) collectionViewLayout:[self getViewLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.testImage.image = self.testImage;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

@end
