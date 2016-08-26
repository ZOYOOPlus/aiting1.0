 //
//  HomeVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HomeVC.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import "RowAdsView.h"
#import "HCameraVC.h"
#import "DataManager.h"
#import "HActivityHeadView.h"
#import "ShowVC.h"
#import "PaintVC.h"
#import "ListenVC.h"
#import "CourseVC.h"
#import "HUIButton.h"
#import "HWebView.h"
#import "HCameraVC.h"
#import "LFYSessionManager.h"
#import "PlayVC.h"
#import "BannerDao.h"
#import "BannerPhotoModel.h"
#import "BannerCell.h"
#import <SDWebImage/SDImageCache.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MJRefresh/MJRefresh.h>
static NSString *cellId = @"cellID";
static void * kContentOffSet = &kContentOffSet;
@interface HomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate,RowAdsViewDelegate,ActivityCellDelegate>
@property (nonatomic,strong)HActivityHeadView *headView;
@property (nonatomic, assign) BOOL isYouWang;
@property (nonatomic,strong)NSArray *BannerPhontoArray;
@property (nonatomic,assign) int  page;
@property  (nonatomic,strong) HWebView *webView;
@end

@implementation HomeVC

- (HWebView *)webView{
 
    if (!_webView) {
        _webView = [[HWebView alloc]init];
    }
    return _webView;
}

-(SDCycleScrollView *)banner{

    if (_banner == nil) {
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kBannerHeight) imageURLStringsGroup:nil];
        _banner.placeholderImage = [UIImage imageNamed:@"head,jpg"];
        _banner.backgroundColor = [UIColor whiteColor];
        _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _banner.autoScrollTimeInterval = 3.5f;
        _banner.delegate = self;
    }
    return _banner;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView addSubview:self.banner];
    
    // 255  100   0
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:0.0/255.0 alpha:1.0]];
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    
    
    // 设置 标题字体的颜色
  //  [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:100.0/255.0 blue:0.0/255.0 alpha:1.0],UITextAttributeTextColor,nil]];
   // NSLog(@"%@",[UIScreen mainScreen].bounds.size) ;
    
    
    
     self.tabBarController.navigationItem.title = @"爸妈特爱";
//    [self.tabBarController.navigationController.navigationItem ]

    UIImageView *imageView = [[UIImageView  alloc]init];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.collectionView.bounds.size.height);
    
//    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        self.page=1;
//        //[self httprequstWithPage:self.page withdish_id:@""];
//        [self loadNewData];
//        [self.collectionView  reloadData];
//    }];
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
               
                
                
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
     //  [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"%ld", (long)status);
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            self.isYouWang = NO;
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:NULL message:@"请检查网络" delegate:NULL
                                      cancelButtonTitle:@"确定" otherButtonTitles:NULL];
            [alertView show];
 
        }
        
    }];
    
    
    [self setup];
    
   // [self loadNewData];
    
    //[self.collectionView reloadData];
    
}

- (void)getbannerMessage {
    [self showProgressView:nil];
    [ BannerDao getBannerPhotoWithUserId:nil sucess:^(NSArray *list) {
        [self hidenProgress];
        self.BannerPhontoArray = list;
        [self.collectionView reloadData];
    } fail:^{
        [self hidenProgress];
        [self showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
    }];
}

- (void)showProgressView:(NSString *)message{
    MBProgressHUD *pro = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    pro.labelFont = [UIFont systemFontOfSize:15];
    pro.labelText = message;
    [self.view bringSubviewToFront:self.navigationController.navigationBar];
}




//数据请求

//api/article/recent/?source=0&count=20&category=童书绘本&offset=0
//  &#31461;&#20070;&#32472;&#26412;
//- (void)loadNewData{
//
//        [LFYSessionManager dataWithUrlString:@"/api/article/recent/?source=2&count=20&category=%E7%AB%A5%E4%B9%A6%E7%BB%98%E6%9C%AC&offset=0" andSuccessBlock:^(id data) {
//            
//            //NSLog(@"%@",data);
//            NSArray * arr = [[NSArray alloc] init];
//            NSMutableArray * arrM = @[].mutableCopy;
//            arr = data[@"data"];
//            
//            
//            for (int i = 0;  i < arr.count; i ++) {
//                ActivityModel * model = [[ActivityModel alloc] iniTWithDict:(NSDictionary *)data[@"data"][0]];
//                model.image_list = ((NSDictionary *)arr[i])[@"image_list"];
//                model.middle_image =((NSDictionary *)arr[i])[@"middle_image"];
//                model.title=((NSDictionary *)arr[i])[@"title"];
//                model.media_name =((NSDictionary *)arr[i])[@"media_name"];
//                model.display_url =((NSDictionary *)arr[i])[@"display_url"];
//                
//                if (model.image_list.count == 0)
//                {
//                    //                            return cell;
//                    NSLog(@"没有图片不加载");
//                    
//                }else{
//                    [arrM addObject:model];
//                    //    [arrM addObject:model];
//                    NSLog(@"%@",model);
//                }
//                NSLog(@"请求成功");
//                self.dataSource = arrM;
//                
//                [self.collectionView reloadData];
//                
//            }
//            
//        } failureBlock:^(NSError *error) {
//            
//        }];
//    
//}

- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];

    }
    
    return _dataSource;
    
}

- (void)setup{
    // 开启本地数据源 加载新闻 
   _dataSource = [[DataManager shareInstance] getActivityData];
    [self.view addSubview:self.collectionView];
    [self addBanner];
    [self addActivityTitleView];
    [self initadsView];
    
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:kContentOffSet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.title = @"爸妈特爱";
}

- (void)addActivityTitleView{
     self.headView = [[HActivityHeadView alloc] initWithFrame:CGRectMake(0, kBannerHeight + [RowAdsView contentHeight] , CGRectGetWidth(self.view.bounds), kHeadHeight)];
    self.headView.dataSource = [[DataManager shareInstance] getActivityTitleData];
    [self.collectionView addSubview:self.headView];
}

- (void)addBanner{
    AVQuery* query = [AVQuery queryWithClassName:AT_BANNER];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==NULL && objects!= NULL && objects.count > 0) {
            
            NSMutableArray *arrM = [NSMutableArray  arrayWithCapacity:42];
            for (int i = 0; i < objects.count; i ++) {
                AVFile* imageFile1 = [objects[i] objectForKey:@"BannerPhoto"];
                NSString *bannerurl = [imageFile1 url];
                [arrM addObject:bannerurl];
            }
            self.banner.imageURLStringsGroup = arrM;
        }
    }];
}

- (void)initadsView{
    RowAdsView *adsView = [[RowAdsView alloc] initWithPostionY:kBannerHeight];

    adsView.adsArray = [[DataManager shareInstance] getAdsArray];
    adsView.adsDelegate = self;
    [self.collectionView addSubview:adsView];
  
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, kBannerHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(kBannerHeight + [RowAdsView contentHeight] + kHeadHeight + 5, 0, self.tabBarController.tabBar.bounds.size.height + 66, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[ActivityCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundView = [[UIView alloc] initWithFrame:_collectionView.bounds];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    ActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.activityModel = self.dataSource[indexPath.row];
    
    // 加载本地的时候的cell
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCell *cell = (ActivityCell *)[collectionView cellForItemAtIndexPath:indexPath];
 
        self.webView.urlstr = cell.activityModel.displayURL;
        [self.tabBarController.navigationController pushViewController:self.webView animated:YES];
    

}

#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (context == kContentOffSet) {
        if (self.collectionView.contentOffset.y >= kBannerHeight + [RowAdsView contentHeight] ) {
            self.headView.y = self.collectionView.contentOffset.y;
        }else{
            self.headView.y = kBannerHeight + [RowAdsView contentHeight];
        }
    }
}

#pragma mark action

- (void)selectAdsAtIndex:(NSInteger)index{
    if (index == 2) {
        HCameraVC *vc = [[HCameraVC alloc] init];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }else if (index == 1){
//        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"DrawVC" bundle:nil];
//        [self.tabBarController.navigationController pushViewController:[storyBoard instantiateInitialViewController] animated:YES];
        PaintVC *vc = [[PaintVC alloc] init];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }else if (index == 0){
        ListenVC *vc = [[ListenVC alloc] init];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }else{
        CourseVC *vc = [[CourseVC alloc] init];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)selectImageViewListAtIndex:(NSIndexPath *)indexPath data:(ActivityModel *)data{
    HWebView *webView = [[HWebView alloc] initWithURLString:data.displayURL];
    [self.tabBarController.navigationController pushViewController:webView animated:YES];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{


  // 点击多次cell  只响应最后一次
    AVQuery* query = [AVQuery queryWithClassName:AT_BANNER];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (![self.tabBarController.navigationController.childViewControllers.lastObject isKindOfClass:[HWebView class]]) {
            NSString *bannerurl = [objects[index] objectForKey:@"Banner_URL"];
            HWebView *webView = [[HWebView alloc] initWithURLString:bannerurl];
            [self.tabBarController.navigationController pushViewController:webView animated:YES];
        }
    }];
    
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(void)viewDidAppear:(BOOL)animated{
    
    //[self.headView removeFromSuperview ];
    //[self setup];
 
   // [self loadNewData];
      self.tabBarController.navigationItem.title = @"爸妈特爱";
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    //[mgr startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"%ld", (long)status);
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:NULL message:@"请检查网络" delegate:NULL
                                      cancelButtonTitle:@"确定" otherButtonTitles:NULL];
            [alertView show];
            
        }
        
    }];

   // [self.collectionView reloadData];
        NSLog(@"viewDidAppear+++");
}

#pragma mark  --下拉刷新 
-(void)HeaderRereshing{
    self.page = 1;
    
}
#pragma mark -- 上拉加载
-(void)FooterRereshing{
    
    self.page ++;
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
@end
