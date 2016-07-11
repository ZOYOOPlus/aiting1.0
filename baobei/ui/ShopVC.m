//
//  ShopVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShopVC.h"
#import "HImageListCell.h"
#import "ShopCell.h"
#import "RowAdsView.h"
#import "DataManager.h"
#import "TesttView.h"
#import "HCommon.h"
#import "ShopDao.h"

static NSString *cellID = @"HImageListCell";

@interface ShopVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RowAdsViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong)  UICollectionView *collectionView;
@property (nonatomic, strong) TesttView *demoImageView;
@property (nonatomic, strong) TesttView *demoImageView2;
@property (nonatomic, strong) NSArray *photoArray;
@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.demoImageView.backgroundColor = [UIColor whiteColor];
//    self.demoImageView2.backgroundColor = [UIColor whiteColor];
    [self initadsView];
//    [self addGoodsphoto];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.demoImageView2];
    [self.view addSubview:self.demoImageView];
    
    [self selectAdsAtIndex:1];
    //数据请求
    [self getShopPhotoMessage];
    
}


- (void)getShopPhotoMessage {
    [self showProgressView:nil];
    [ShopDao getShopPhotoWithUserId:nil sucess:^(NSArray *list) {
        [self hidenProgress];
        self.photoArray = list;
        [self.collectionView reloadData];
    } fail:^{
        [self hidenProgress];
        [self showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"亲子互动";
   
}

//- (UICollectionView *)collectionView{
//    
//}

// 出现抖动 问题
- (TesttView *)demoImageView{
    if (!_demoImageView) {
        _demoImageView = [[TesttView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"kWan.jpg"]];//kWan.jpg
        //红色
       // _demoImageView.backgroundColor = [UIColor redColor];
    }
   
    return _demoImageView;
}

- (TesttView *)demoImageView2{
    if (!_demoImageView2) {
        
        _demoImageView2 = [[TesttView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"ATtome3.jpg"]];//ATdemo.jpg
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _demoImageView2;
}


//- (void)addHeadView{
//    // 3ge button
//    NSArray *titleArray = @[@"限时",@"精选",@"一起玩"];
//    NSArray *color = @[@"#BE92ED",@"#FB7E6F",@"#FF87B2"];
//    NSArray *imageArray = @[@"shop1.png",@"jin.png",@"wan.png"];
//
//    CGFloat margin = 10;
//    CGFloat width = (self.view.frame.size.width - margin *4)/3;
//    //    CGFloat barHeight = self.navigationController.navigationBar.bounds.size.height
//    //    + [[UIApplication sharedApplication] statusBarFrame].size.height;
//    for (int index = 0; index < 3; index++) {
//        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(margin+ (width + margin) * index, margin  , width, 80);
//        [button setImage:[UIImage imageNamed:imageArray[index]] forState:UIControlStateNormal];
//        [button setTitle:titleArray[index] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(clickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTag:index];
//        [button setBackgroundColor:[UIColor colorWithHexString:color[index]]];
//        [self.view addSubview:button];
//    }
//}

- (void)initadsView{
    RowAdsView *adsView = [[RowAdsView alloc] initWithPostionY:0];
    adsView.adsArray = [[DataManager shareInstance] getShopAdsArray];
    adsView.adsDelegate = self;
    [self.view addSubview:adsView];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        CGFloat width = self.view.width/2 - 10 - 5;
        layout.itemSize = CGSizeMake(width , width + 20);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 66, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 100) collectionViewLayout:layout];
        [_collectionView registerClass:[ShopCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];

    }
    
    return _collectionView;
    
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark UICollectionViewDataSource
- (void)addGoodsphoto{
    AVQuery  *query = [AVQuery queryWithClassName:AT_GOODSPHOTO];
    // 升序
    [query addAscendingOrder:@"order"];
    // 降序
   //  [query addDescendingOrder:@"order"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error==NULL && objects!= NULL && objects.count > 0) {
                    AVFile* imageFile1 = [objects[0] objectForKey:@"Photos"];
                    AVFile* imageFile2 = [objects[1] objectForKey:@"Photos"];
                    AVFile* imageFile3 = [objects[2] objectForKey:@"Photos"];
                    AVFile* imageFile4 = [objects[3] objectForKey:@"Photos"];
                    AVFile* imageFile5 = [objects[4] objectForKey:@"Photos"];
                    AVFile* imageFile6 = [objects[5] objectForKey:@"Photos"];
                    AVFile* imageFile7 = [objects[6] objectForKey:@"Photos"];
                    AVFile* imageFile8 = [objects[7] objectForKey:@"Photos"];
                    AVFile* imageFile9 = [objects[8] objectForKey:@"Photos"];
                    AVFile* imageFile10= [objects[9] objectForKey:@"Photos"];
                    
                    NSArray *array = @[[imageFile1 url],[imageFile2 url],[imageFile3 url],[imageFile4 url],[imageFile5 url],[imageFile6 url],[imageFile7 url],[imageFile8 url],[imageFile9 url],[imageFile10 url]];
               SDCycleScrollView *Goodsphoto = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height *10) imageURLStringsGroup:array];
                    Goodsphoto.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
                    Goodsphoto.delegate = self;
                    [self.collectionView addSubview:Goodsphoto];
                }
        
    }];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.shopPhotoMode = self.photoArray[indexPath.row];
//    if(indexPath.row < 2){
    
//    NSString *imgStr = [NSString stringWithFormat:@"update2/xianshi%zd.jpg", indexPath.row+1];
//        cell.goodsImageView.image = [UIImage imageNamed:imgStr];

//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi3.jpg"];
//    }else if(indexPath.row < 4){
//            cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi7.jpg"];
//    }else if (indexPath.row <6){
//    cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi4.jpg"];
//    }else if (indexPath.row <8){
//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi1.jpg"];
//    }else if (indexPath.row <10){
//         cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi6.jpg"];
//    }else if (indexPath.row < 12){
//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi8.jpg"];
//    }else if (indexPath.row < 14){
//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi10.jpg"];
//    }else if (indexPath.row < 16){
//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi5.jpg"];
//    }else if (indexPath.row < 18){
//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi2.jpg"];
//    }else if (indexPath.row < 20){
//        cell.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi9.jpg"];
//    }
    return cell;
}


- (void)selectAdsAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            self.collectionView.hidden = NO;
            self.demoImageView2.hidden = YES;
            self.demoImageView.hidden = YES;
        }
            break;
        case 1:
        {
            self.collectionView.hidden = YES;
            self.demoImageView2.hidden = NO;
            self.demoImageView.hidden = YES;
        }
            break;
        case 2:
        {
            self.collectionView.hidden = YES;
            self.demoImageView2.hidden = YES;
            self.demoImageView.hidden = NO;
        }
            break;
        default:
            break;
    }
//    if (index == 1) {
//        if (!_demoImageView) {
//            [self.view addSubview:self.demoImageView];
//            self.demoImageView.frame = self.collectionView.frame;
////            self.demoImageView.image = [UIImage imageNamed:@"ATdemo.jpg"];
//        }else{
////            self.demoImageView.image = [UIImage imageNamed:@"ATdemo.jpg"];
//        }
//        
//    } else if (index == 2){
//        if (!_demoImageView) {
//            [self.view addSubview:self.demoImageView];
//            self.demoImageView.image = [UIImage imageNamed:@"kWan.jpg"];
//            self.demoImageView.frame = self.collectionView.frame;
//        }else{
//            self.demoImageView.image = [UIImage imageNamed:@"kWan.jpg"];
//            
//        }
//    }
//    else{
//        if (_demoImageView) {
//            [_demoImageView removeFromSuperview];
//            _demoImageView = nil;
//        }
//        
//    }
}


@end
