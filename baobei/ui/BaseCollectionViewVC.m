//
//  BaseCollectionViewVC.m
//  baobei
//
//  Created by 贺少虎 on 16/5/16.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BaseCollectionViewVC.h"

static NSString *cellID = @"id";


@interface BaseCollectionViewVC()

@property (nonatomic, strong)  UICollectionView *collectionView;

@end

@implementation BaseCollectionViewVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

//- (UICollectionView *)collectionView{
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 10;
//        layout.minimumInteritemSpacing = 10;
//        
//        CGFloat width = self.view.width/2 - 10 - 5;
//        layout.itemSize = CGSizeMake(width , width);
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.sectionInset = UIEdgeInsetsMake(80, 10, 66, 10);
//        
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//        [_collectionView registerClass:[HImageListCell class] forCellWithReuseIdentifier:cellID];
//        
//        [_collectionView setDelegate:self];
//        [_collectionView setDataSource:self];
//        _collectionView.backgroundColor = [UIColor clearColor];
//    
//    }
//    return _collectionView;
//}

@end
