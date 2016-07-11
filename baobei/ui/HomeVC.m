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

#import <SDWebImage/SDImageCache.h>


static NSString *cellId = @"cellID";

static void * kContentOffSet = &kContentOffSet;

@interface HomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate,RowAdsViewDelegate,ActivityCellDelegate>

@property (nonatomic,strong)HActivityHeadView *headView;

@property (nonatomic, assign) BOOL isYouWang;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [self.view addSubview:imageView];
//    imageView.frame = CGRectMake(100, 100, 200, 200);
//    
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.iconpng.com/png/windows8_icons2/rfid_sensor.png"] placeholderImage:[UIImage imageNamed:@"home_draw"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"%@", NSStringFromCGSize(image.size));
//        
//    }];
//    
//    return;
    
    UIImageView *imageView = [[UIImageView  alloc]init];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.collectionView.bounds.size.height);
    
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
            
            
//            NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//            
//            ActivityModel *activity = [[ActivityModel alloc] init];
//            activity.title = @"半杯咖啡读好书";
//            activity.media_name = @"半杯咖啡读好书 0评论 2016-05-30 09:21";
//            NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
//            
//            [imageList addObject:[UIImage imageNamed:@"thumb.jpg"]];
//            [imageList addObject:[UIImage imageNamed:@"thumb.jpg"]];
//            [imageList addObject:[UIImage imageNamed:@"thumb.jpg"]];
//            
//            activity.image_list = imageList;
//            activity.display_url = @"http://toutiao.com/group/6290302795711971585/";
//            [array addObject:activity];
            
            
        }
        
    }];
    
    
    [self setup];
    
    [self loadNewData];
    
    [self.collectionView reloadData];
    
}



    




//数据请求

//api/article/recent/?source=0&count=20&category=童书绘本&offset=0
//  &#31461;&#20070;&#32472;&#26412;
- (void)loadNewData{
//、、ReachabilityStatus status = [RealReachability currentReachabilityStatus];
//    if (afn == 0) {
//    
//        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//        
//        ActivityModel *activity = [[ActivityModel alloc] init];
//        activity.title = @"半杯咖啡读好书";
//        activity.media_name = @"半杯咖啡读好书 0评论 2016-05-30 09:21";
//        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
//        
//        [imageList addObject:[UIImage imageNamed:@"thumb.jpg"]];
//        [imageList addObject:[UIImage imageNamed:@"thumb.jpg"]];
//        [imageList addObject:[UIImage imageNamed:@"thumb.jpg"]];
//        
//        activity.image_list = imageList;
//        activity.display_url = @"http://toutiao.com/group/6290302795711971585/";
//        [array addObject:activity];
//        
//        
//    }else{
//    if (AFNetworkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
//        if (&la_status == AFNetworkReachabilityStatusNotReachable) {
    
            
//    if (self.isYouWang) {
        [LFYSessionManager dataWithUrlString:@"/api/article/recent/?source=2&count=20&category=%E7%AB%A5%E4%B9%A6%E7%BB%98%E6%9C%AC&offset=0" andSuccessBlock:^(id data) {
            
            //NSLog(@"%@",data);
            NSArray * arr = [[NSArray alloc] init];
            NSMutableArray * arrM = @[].mutableCopy;
            arr = data[@"data"];
            
            
            for (int i = 0;  i < arr.count; i ++) {
                ActivityModel * model = [[ActivityModel alloc] iniTWithDict:(NSDictionary *)data[@"data"][0]];
                model.image_list = ((NSDictionary *)arr[i])[@"image_list"];
                model.middle_image =((NSDictionary *)arr[i])[@"middle_image"];
                model.title=((NSDictionary *)arr[i])[@"title"];
                model.media_name =((NSDictionary *)arr[i])[@"media_name"];
                model.display_url =((NSDictionary *)arr[i])[@"display_url"];
                
                if (model.image_list.count == 0)
                {
                    //                            return cell;
                    NSLog(@"没有图片不加载");
                    
                }else{
                    [arrM addObject:model];
                    //    [arrM addObject:model];
                }
                NSLog(@"请求成功");
                self.dataSource = arrM;
                
                [self.collectionView reloadData];
                
            }
            
        } failureBlock:^(NSError *error) {
            
        }];
//    }
//else {
//        
//        
//        
//    }
//        

    
}

- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
        
        
    }
    
    return _dataSource;
    
}

- (void)setup{
//    _dataSource = [[DataManager shareInstance] getActivityData];
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
            AVFile* imageFile1 = [objects[0] objectForKey:@"BannerPhoto"];
            AVFile* imageFile2 = [objects[1] objectForKey:@"BannerPhoto"];
            AVFile* imageFile3 = [objects[2] objectForKey:@"BannerPhoto"];
            AVFile* imageFile4 = [objects[3] objectForKey:@"BannerPhoto"];
            AVFile* imageFile5 = [objects[4] objectForKey:@"BannerPhoto"];
            AVFile* imageFile6 = [objects[5] objectForKey:@"BannerPhoto"];
            
            NSArray *array = @[[imageFile1 url],[imageFile2 url],[imageFile3 url],[imageFile4 url],[imageFile5 url],[imageFile6 url]];
            
            SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kBannerHeight) imageURLStringsGroup:array];
            banner.placeholderImage = [UIImage imageNamed:@"head.jpg"];

            banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            banner.autoScrollTimeInterval = 3.5f;
            banner.delegate = self; 
            [self.collectionView addSubview:banner];
            
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
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 2) {
//        //测试用代码
////        [self.tabBarController.navigationController pushViewController:[[HCameraVC alloc] init] animated:NO];
//    }
    ActivityModel *model = self.dataSource[indexPath.row];
//    ActivityCell *cell = (ActivityCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSLog(@"url %@",cell.activityModel.displayURL);
    HWebView *webView = [[HWebView alloc] initWithURLString:model.display_url];
    [self.tabBarController.navigationController pushViewController:webView animated:YES];
    
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
    HWebView *webView = [[HWebView alloc] initWithURLString:data.display_url];
    [self.tabBarController.navigationController pushViewController:webView animated:YES];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString *aiqiyi = @"http://www.iqiyi.com/kszt_phone/bbegdq.html";
    NSString *weiixn=@"http://mp.weixin.qq.com/s?__biz=MzI0MjQzOTM4NQ==&mid=2247483658&idx=1&sn=488f3b3afdd9fea0d06faf4b4c5a488c&scene=4#wechat_redirect";
    NSString *yinghuo = @"https://mp.weixin.qq.com/s?__biz=MjM5NTAzNzE4MA==&mid=2652529540&idx=2&sn=1596886f59e4d10e50467d46aa685ce6&scene=2&srcid=0629edxiSPd69JHAzGTUS7hx&from=timeline&isappinstalled=0&key=77421cf58af4a6536104d908149a219a3d559f55883c3a80a18069d721683639ea06d0d0375abdc12e3e22821552bc5d&ascene=2&uin=ODU3MTk2MTIx&devicetype=iPhone+OS9.3.2&version=16031610&nettype=WIFI&fontScale=100&pass_ticket=w%2Fe4Kgho12KeTXg%2F1J9IE8n%2FadcynrckujwZ6Xpm0K4nXat9xmV0lwPfgIvww%2B9n";
    NSString *peiban = @"http://www.dreamaking.net/schedule/html/main.html?from=groupmessage&isappinstalled=0";
    if (index == 4) {
        HWebView *webView  =[[HWebView alloc]initWithURLString:weiixn];
        [self.tabBarController.navigationController pushViewController:webView animated:YES];
    }else if(index == 5){
        HWebView *webView  =[[HWebView alloc]initWithURLString:yinghuo];
        [self.tabBarController.navigationController pushViewController:webView animated:YES];
    }else if(index == 0){
        HWebView *webView  =[[HWebView alloc]initWithURLString:peiban];
        [self.tabBarController.navigationController pushViewController:webView animated:YES];
    }

    
    else{
    HWebView *webView = [[HWebView alloc] initWithURLString:aiqiyi];
        [self.tabBarController.navigationController pushViewController:webView animated:YES];
    }
    
}
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.headView removeFromSuperview ];
      [self setup];
 
    [self loadNewData];
    
    
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


@end
