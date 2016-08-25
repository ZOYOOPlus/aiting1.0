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
#import "HWebView.h"

static NSString *cellID = @"HImageListCell";

@interface ShopVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RowAdsViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong)  UICollectionView *collectionView;
@property (nonatomic, strong) TesttView *demoImageView;
@property (nonatomic, strong) TesttView *demoImageView2;
@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic,strong)  NSArray  *PriceArray;
@property (nonatomic,strong)  NSArray  *SellArray;
@property (nonatomic ,strong) NSArray  *AddressArray;
@property  (nonatomic,strong) NSArray  *NameArray;
@property (nonatomic,strong) HWebView *webView;
@end

@implementation ShopVC


-(HWebView *)webView
{
    if (!_webView) {
        _webView = [[HWebView alloc]init];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换";
    self.view.backgroundColor = [UIColor whiteColor];
   self.collectionView.backgroundColor = [UIColor clearColor];
  // self.demoImageView.backgroundColor = [UIColor whiteColor];
  // self.demoImageView2.backgroundColor = [UIColor whiteColor];
    [self initadsView];
//    [self addGoodsphoto];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.demoImageView2];
    [self.view addSubview:self.demoImageView];
    
    [self selectAdsAtIndex:0];
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
        _demoImageView = [[TesttView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"kWan.jpg"]];//kWan.jpg
//      //  红色
//        _demoImageView.backgroundColor = [UIColor redColor];
    }
   
    return _demoImageView;
}

- (TesttView *)demoImageView2{
    if (!_demoImageView2) {
        
        _demoImageView2 = [[TesttView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"ATtome3.jpg"]];//ATdemo.jpg
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _demoImageView2;
}


- (void)initadsView{
    RowAdsView *adsView = [[RowAdsView alloc] initWithPostionY:0];
    adsView.adsArray = [[DataManager shareInstance] getShopAdsArray];
    adsView.adsDelegate = self;
    [self.view addSubview:adsView];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      
        layout.minimumInteritemSpacing = 10;
        
        CGFloat width = self.view.width/2 - 10 - 5;
        layout.itemSize = CGSizeMake(width , width + 30);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 66, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height -170) collectionViewLayout:layout];
        [_collectionView registerClass:[ShopCell class] forCellWithReuseIdentifier:cellID];
        
//        _collectionView.layer.borderWidth = 5;
//        _collectionView.layer.borderColor = [[UIColor  orangeColor]CGColor];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];

    }
    
    return _collectionView;
    
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
        AVQuery* query = [AVQuery queryWithClassName:@"GoodsPhoto"];
       [query orderByAscending:@"order"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(![self.navigationController.childViewControllers.lastObject isKindOfClass:[HWebView class]]){
            NSString *GPURL = [objects[indexPath.row] objectForKey:@"GP_URL"];
                if (GPURL == NULL){
                
                
                }else{
            HWebView *webView = [[HWebView alloc] initWithURLString:GPURL];
            [self.navigationController pushViewController:webView animated:YES];
                }
        }
      }];
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count;
    return self.PriceArray.count;
    return self.SellArray.count;
    return self.NameArray.count;
    return self.AddressArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [[UIColor orangeColor] CGColor];
    cell.price.text = self.PriceArray[indexPath.row];
    cell.sales.text = self.SellArray [indexPath.row];
    cell.address.text = self.AddressArray[indexPath.row];
    cell.goodsName.text = self.NameArray [indexPath.row];
    cell.shopPhotoMode = self.photoArray[indexPath.row];
    
    //cell.selected = NO;
    
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

}


@end
