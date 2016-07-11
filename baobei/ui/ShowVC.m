//
//  ShowVC.m
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowVC.h"
#import "HImageListCell.h"
#import "ShowCell.h"

static NSString *cellID = @"HImageListCell";

@interface ShowVC()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectType;
@end

@implementation ShowVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self addHeadView];
    self.selectType = 1;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"秀";
}

- (void)addHeadView{
    // 3ge button
    NSArray *titleArray = @[@"小画家",@"小主播",@"小能手"];
    NSArray *color = @[@"#BE92ED",@"#FB7E6F",@"#FF87B2"];
    CGFloat margin = 10;
    CGFloat width = (self.view.frame.size.width - margin *4)/3;
    //    CGFloat barHeight = self.navigationController.navigationBar.bounds.size.height
    //    + [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat barHeight = 0;
    for (int index = 0; index < 3; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(margin+ (width + margin) * index, margin + barHeight , width, 40);
        [button setTitle:titleArray[index] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithHexString:color[index]]];
        [button setTag:index + 1];
        [button addTarget:self action:@selector(clickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)setSelectType:(NSInteger)selectType{
    if (_selectType == selectType) {
        return;
    }
    _selectType = selectType;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        CGFloat width = self.view.width/2 - 10 - 5;
        layout.itemSize = CGSizeMake(width , width * kItemWidthHeigthScale);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 66, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height - 66 ) collectionViewLayout:layout];
        [_collectionView registerClass:[ShowCell class] forCellWithReuseIdentifier:cellID];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"PaintVC" bundle:nil];
//    [self.navigationController pushViewController:[storyBoard instantiateInitialViewController] animated:YES];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    if (self.selectType == 1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"hua01.jpg"];
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"hua03.jpg"];
        } else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"hua04.jpg"];
        }else if (indexPath.row == 3){
            cell.imageView.image = [UIImage imageNamed:@"hua04.jpg"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"hua05.jpg"];
        }
    }else if (self.selectType == 2){
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"xiao_1.png"];
        }
//        else if (indexPath.row == 2){
//            cell.imageView.image = [UIImage imageNamed:@"xiao_2.jpg"];
//        } else if (indexPath.row == 2){
//            cell.imageView.image = [UIImage imageNamed:@"xiao_2.jpg"];
//        }else if (indexPath.row == 2){
//            cell.imageView.image = [UIImage imageNamed:@"hua04.jpg"];
//        }
        else{
            cell.imageView.image = [UIImage imageNamed:@"xiao_2.png"];
        }
    }else{
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"update2/shougong.jpg"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"update2/shougong2.jpg"];
        }
    }
    
    return cell;
}



- (void)clickHeadButton:(id)sender{
    self.selectType = [sender tag];
}

@end
