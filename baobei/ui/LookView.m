//
//  LookView.m
//  baobei
//
//  Created by 张源海 on 16/8/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LookView.h"
#import "LookCollectionViewCell.h"
#import "LookPhotoModel.h"
#import "LookDao.h"
#import "HCommon.h"
#import "VideoVC.h"

static NSString *cellID = @"HImageListCell";

 static UIViewController *superVC;

@interface LookView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic,strong)  NSArray  *TitleArray;

@end


@implementation LookView

- (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
     return nil;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
        //[self.contentView addSubview:self.LooktitleLabel];
      //  [self addSubview:self.VideoPlayer];
        [self getLookPhotoMessage];
        [self.collectionView  reloadData];

        }
    return self;

}

//- (void)getShopPhotoMessage {
//    [self showProgressView:nil];
//    [ShopDao getShopPhotoWithUserId:nil sucess:^(NSArray *list) {
//        [self hidenProgress];
//        self.photoArray = list;
//        [self.collectionView reloadData];
//    } fail:^{
//        [self hidenProgress];
//        [self showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
//    }];
//}
- (void)getLookPhotoMessage{
   // [self showProgressView: nil]

    [LookDao getLookPhotoWithUserId:nil sucess:^(NSArray *list) {
        self.photoArray = list;
        [self.collectionView reloadData];
    } fail:^{
//        [self. hidenProgress];
//        [self showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
    }];

}
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self.lookimage = image;
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
     //   layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 100);
    CGFloat width = self.frame.size.width;
    //layout.itemSize = CGSizeMake(width,  width/_lookimage.size.width  * _lookimage.size.height + 50);
     layout.itemSize = CGSizeMake(width,  width/3);
    return layout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, fDeviceWidth*0.12, fDeviceWidth, self.height-20-64) collectionViewLayout:[self getViewLayout]];
//           _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, superVC.view.frame.size.width, superVC.view.frame.size.height -170) collectionViewLayout:[self getViewLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LookCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    
   // ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [[UIColor orangeColor] CGColor];
   cell.LooktitleLabel.text = self.TitleArray[indexPath.row];

    cell.LookPhotoModel = self.photoArray[indexPath.row];
//    if (indexPath.row ==0) {
//        cell.Lookimages.image = self.lookimage;
//    }else if (indexPath.row ==1){
//
//        cell.Lookimages.image = [UIImage imageNamed:@"爱探险的朵拉.jpg"];
//    }else if (indexPath.row ==2){
//        
//        cell.Lookimages.image = [UIImage imageNamed:@"粉红猪小妹.jpg"];
//    }else if (indexPath.row ==3){
//        
//        cell.Lookimages.image = [UIImage imageNamed:@"可爱巧虎岛.jpg"];
//    }else if (indexPath.row ==4){
//        
//        cell.Lookimages.image = [UIImage imageNamed:@"小企鹅.jpg"];
//    }
//    else if (indexPath.row ==5){
//        
//        cell.Lookimages.image = [UIImage imageNamed:@"天线宝宝.jpg"];
//    }

    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
      return self.photoArray.count;
    return self.TitleArray.count;

    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.row == 5) {
        
            VideoVC *vc = [[VideoVC alloc] init];
            VideoEntity *video = [[VideoEntity alloc] init];
            // 电台连接
           // video.mp4URL = @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
           //video.mp4URL = @"http://live.3gv.ifeng.com/live/hongkong.m3u8";
            video.mp4URL = @"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8";
//            video.mp4URL = @"http://data.vod.itc.cn/?rb=1&prot=1&key=jbZhEJhlqlUN-Wj_HEI8BjaVqKNFvDrn&......yEIezSTaLA.mp4 ";
            vc.video = video;
            [superVC.navigationController pushViewController:vc animated:YES];
        
    }else{
    
   superVC = [self viewController:self];
    AVQuery* query = [AVQuery queryWithClassName:@"LookViewPhoto"];
    [query orderByAscending:@"order"];

    //[query orderByDescending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(![superVC.navigationController.childViewControllers.lastObject isKindOfClass:[HWebView class]]){
            NSString *GPURL = [objects[indexPath.row] objectForKey:@"Look_URL"];
            if (GPURL == NULL){
                
                
            }else{
                HWebView *webView = [[HWebView alloc] initWithURLString:GPURL];
                [superVC.navigationController pushViewController:webView animated:YES];
            }
        }
    }];
        
    }
    
//
//    HWebView *webViewlook = [[HWebView alloc]initWithURL:[NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/97AF0151CDF7AF6F638CA62FA906FE98.flv?sc=33d6114ad3f11e1d"]];
// 
//    superVC = [self viewController:self];
//    
//    [superVC.navigationController pushViewController:webViewlook animated:YES];

    
}
@end
