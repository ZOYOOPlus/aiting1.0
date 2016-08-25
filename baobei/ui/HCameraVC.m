//
//  HCameraVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/26.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HCameraVC.h"
#import <FastttCamera/FastttCamera.h>
#import "HCommon.h"
#import <Masonry.h>
#import "HMImageCell.h"
#import "HMLineLayout.h"
@import AssetsLibrary;
@import MessageUI;

@interface HCameraVC () <FastttCameraDelegate,MFMailComposeViewControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic,strong) FastttCamera * fastCamera;
@property (nonatomic,strong) UIImageView *lineView;
@property (nonatomic, strong) UIImageView *previewImageView;

@property (nonatomic,strong)HMImageCell *oldCell;

// 所有的图片名
@property (nonatomic, strong) NSMutableArray *images;


@end

@implementation HCameraVC

static NSString *const ID = @"image";


- (NSMutableArray *)images {
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
        
        for (int i = 0; i <= 31; i++) {
            [self.images addObject:[NSString stringWithFormat:@"emogi_0%d", i]];
        }
    }
    return _images;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        
        
        
        //       UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //              layout.sectionInset = UIEdgeInsetsMake(kBannerHeight + [RowAdsView contentHeight] + kHeadHeight + 5, 0, self.tabBarController.tabBar.bounds.size.height + 66, 0);
        
        //              _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        CGRect rect = CGRectMake(0, fDeviceHeight-60-64-20, fDeviceWidth, 80);
        
        // 创建布局
        HMLineLayout *layout = [[HMLineLayout alloc] init];
        layout.minimumLineSpacing = 25;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(80  , 80);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        // 创建CollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        
        // 删除XIb  加载 Cell
        [collectionView registerNib:[UINib nibWithNibName:@"HMImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
        //       [_collectionView registerClass:[HMImageCell class] forCellWithReuseIdentifier:cellId];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}


//
//- (UICollectionView *)collectionView{
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 10;
//        layout.minimumInteritemSpacing = 0;
//        layout.itemSize = CGSizeMake(self.view.bounds.size.width, kBannerHeight);
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.sectionInset = UIEdgeInsetsMake(kBannerHeight + [RowAdsView contentHeight] + kHeadHeight + 5, 0, self.tabBarController.tabBar.bounds.size.height + 66, 0);
//
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//        [_collectionView registerClass:[ActivityCell class] forCellWithReuseIdentifier:cellId];
//        _collectionView.backgroundView = [[UIView alloc] initWithFrame:_collectionView.bounds];
//        _collectionView.backgroundColor = [UIColor clearColor];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//
//    }
//    return _collectionView;
//}





-(SDCycleScrollView *)footview{
    
    if (_footview == nil) {
        _footview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, fDeviceHeight-60-64-0, self.view.bounds.size.width, 60) imageURLStringsGroup:nil];
        _footview.backgroundColor = [UIColor whiteColor];
        _footview.placeholderImage = [UIImage imageNamed:@"head,jpg"];
        _footview.backgroundColor = [UIColor whiteColor];
        _footview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _footview.autoScrollTimeInterval = 3.5f;
        _footview.delegate = self;
        
        
    }
    return _footview;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    cell.image = self.images[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HMImageCell *cell = (HMImageCell *)[collectionView  cellForItemAtIndexPath:indexPath];
    
    //    if (indexPath.row ==0) {
    
    cell.imageView.layer.borderColor = [[UIColor  orangeColor]CGColor];
    cell.imageView.layer.borderWidth =2.0f;
    
    if (_oldCell) {
        
        _oldCell.imageView.layer.borderWidth = 0.0f;
        
    }
    
    _oldCell = cell;
    
    //       [cell.imageView setValue:@5 forKeyPath:@"layer.borderWidth"];
    //        cell.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    //        cell.imageView.image = [UIImage imageNamed:@"01"];
    
    //    }else if (indexPath.row == 1){
    //
    //        cell.imageView.layer.borderColor = [[UIColor  orangeColor]CGColor];
    //        cell.imageView.layer.borderWidth =2.0f;
    
    //    }
    
}
// 没有毛用
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//
//    return 50;
//
//}




- (void)dismissConfirmController
{
    [self.delegate dismissConfirmController:self];
}
- (void)setImagesReady:(BOOL)imagesReady
{
    _imagesReady = imagesReady;
    if (imagesReady) {
        //  self.confirmButton.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _fastCamera = [[FastttCamera alloc] init];
    _fastCamera.delegate = self;
    [self fastttAddChildViewController:self.fastCamera];
    
    
    if ([UIScreen mainScreen].bounds.size.width== 320) {
        self.fastCamera.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.88);
    }else{
        
        self.fastCamera.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.90);
    }
    
    
    UIView *mask = [[UIView alloc] initWithFrame:self.fastCamera.view.frame];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_banner_1"]];
    [mask addSubview:imageView];
    imageView.frame = CGRectMake(10, 10, 30, 30);
    
    [self.fastCamera.view addSubview:mask];
    [mask addSubview:imageView];
    
    _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"faguang.png"]];
    _lineView.frame = CGRectMake(0, -40, self.view.frame.size.width, 30);
    _lineView.contentMode = UIViewContentModeScaleToFill;
    [self.fastCamera.view addSubview:_lineView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitle:@"拍照" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"learn/Camera31.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"learn/Camera3.png"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.size.mas_equalTo(CGSizeMake(96*0.6, 96*0.6));
    }];
    
    [button addTarget:self action:@selector(clickTake) forControlEvents:UIControlEventTouchUpInside];
    
    _previewImageView = [[UIImageView alloc] initWithImage:self.capturedImage.rotatedPreviewImage];
    self.previewImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.previewImageView];
    [self.previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    
    
    [self.view addSubview:_collectionView];
    NSLog(@"%@",self.collectionView);
    
    [self didStopAnimation];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didStopAnimation{
    _lineView.frame = CGRectMake(0, -30, self.view.frame.size.width, 30);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    _lineView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 30);
    
    [UIView commitAnimations];
}

- (void)clickButton{
    if (_fastCamera.cameraDevice == FastttCameraDeviceFront) {
        _fastCamera.cameraDevice = FastttCameraDeviceRear;
    }else{
        _fastCamera.cameraDevice = FastttCameraDeviceFront;
    }
}

- (void)clickTake{
    [_fastCamera takePicture];
    
    //    [self savePhotoToCameraRoll];
}

- (void)savePhotoToCameraRoll
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[self.capturedImage.fullImage CGImage]
                              orientation:(ALAssetOrientation)[self.capturedImage.fullImage imageOrientation]
     
                          completionBlock:^(NSURL *assetURL, NSError *error){
                              if (error) {
                                  NSLog(@"Error saving photo: %@", error.localizedDescription);
                                  NSLog(@"失败时照片%@",self.capturedImage.fullImage);
                                  
                              } else {
                                  NSLog(@"Saved photo to saved photos album.");
                                  NSLog(@"成功时照片%@",self.capturedImage.fullImage );
                              }
                          }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma 代理

- (void)cameraController:(id<FastttCameraInterface>)cameraController didFinishCapturingImage:(FastttCapturedImage *)capturedImage
{
    // 拍照赋值
    _capturedImage = capturedImage;
    
    [self savePhotoToCameraRoll];
    
    NSLog(@"%@",capturedImage.fullImage);
    NSLog(@"A photo was taken");
    
}

- (void)cameraController:(id<FastttCameraInterface>)cameraController didFinishNormalizingCapturedImage:(FastttCapturedImage *)capturedImage
{
    NSLog(@"---%@",capturedImage.fullImage);
    NSLog(@"Photos are ready");
    
}




@end
