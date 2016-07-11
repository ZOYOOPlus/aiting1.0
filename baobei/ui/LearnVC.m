//
//  LearnVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LearnVC.h"
#import "ListenCell.h"
#import "DataManager.h"
#import "HUIButton.h"
#import "RowAdsView.h"
#import "RecordingView.h"
#import "VideoView.h"
#import "VideoVC.h"
#import "TesttView.h"

static NSString *cellID = @"ListenCell";

@interface LearnVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RowAdsViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSoure;
@property (nonatomic, strong) RecordingView *recordView;
//@property (nonatomic, strong) VideoView  *videoView;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) TesttView *demoImageView2;
@end

@implementation LearnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initadsView];
    [self.view addSubview:self.demoImageView2];

//    [self.view addSubview:self.collectionView];
    _dataSoure =[[DataManager shareInstance] getListenList];
    _selectIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"成长空间";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]  initWithTitle:@"锁" style:UIBarButtonItemStylePlain target:self action:@selector(clickLock)];
    self.tabBarController.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


- (void)initadsView{
    RowAdsView *adsView = [[RowAdsView alloc] initWithPostionY:0];
    adsView.adsArray = [[DataManager shareInstance] getLearnAdsArray];
    adsView.adsDelegate = self;
    [self.view addSubview:adsView];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        
        CGFloat width = self.view.width/2 - 10 - 5;
        layout.itemSize = CGSizeMake(width , width - 30);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(-10, 10, 66 * 2 + 30, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 100) collectionViewLayout:layout];
        [_collectionView registerClass:[ListenCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (RecordingView *)recordView{
    if (!_recordView) {
        _recordView = [[RecordingView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 120)];
        
    }
    return _recordView;
}

- (TesttView *)demoImageView2{
    if (!_demoImageView2) {
        
        _demoImageView2 = [[TesttView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"K_demo.jpg"]];
    }
    return _demoImageView2;
}

//- (TesttView *)videoView{
//    if (!_videoView) {
//        _videoView = [[TesttView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"kWan.jpg"]];
//        
////        _videoView = [[TesttView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"kWan.jpg"]];
////        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideo)];
////        
////        [_videoView addGestureRecognizer:tap];
//
//    }
//    return _videoView;
//}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSoure.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.data = self.dataSoure[indexPath.row];
    return cell;
}

- (void)clickLock{
    
    
}

- (void)resetView{
    if (_selectIndex == 0) {
        [self.demoImageView2 removeFromSuperview];
    }else if (_selectIndex == 1){
        [self.collectionView removeFromSuperview];
    }else if (_selectIndex == 2){
        [self.recordView removeFromSuperview];
    }
}

- (void)selectAdsAtIndex:(NSInteger)index{
    if (_selectIndex == index) {
        return;
    }else{
        [self resetView];
        _selectIndex = index;
        if (_selectIndex == 0) {
            [self.view addSubview:self.demoImageView2];
        }else if (_selectIndex == 1){
            [self.view addSubview:self.collectionView];
        }else if (_selectIndex == 2){
            [self.view addSubview:self.recordView];
        }
    }
}

- (void)clickVideo{
    VideoVC *vc = [[VideoVC alloc] init];
    VideoEntity *video = [[VideoEntity alloc] init];
    video.mp4URL = @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
    vc.video = video;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}


@end
