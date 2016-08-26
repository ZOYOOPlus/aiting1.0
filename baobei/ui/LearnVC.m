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
#import "LookView.h"
#import "BookVC.h"
#import "AppDelegate.h"
#import "ActionSheetStringPicker.h"
#import "PlayerManager.h"
#import "HWebView.h"
#import "LookCollectionViewCell.h"


static NSString *cellID = @"ListenCell";

static  NSString  *ceiiid = @"LookCollectionViewCell";
// 遵守代理
@interface LearnVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RowAdsViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,ListenCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSoure;
@property (nonatomic, strong) RecordingView *recordView;

@property (nonatomic,strong)UIButton *item;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) LookView *demoImageView2;
@property  (nonatomic,strong) UIButton  *BookSlectBtn;
@property  (nonatomic,strong) UIView  *btnView;

@property  (nonatomic,strong) ListenCell *oldCell; // 记录上一个cell 的 状态
@property (nonatomic,assign)NSIndexPath *selectIndexPath;


@property  (nonatomic, strong) UIPickerView *pickerView;
@property  (nonatomic, strong) NSArray *timeArray;
@property  (nonatomic, strong) UILabel *displayTextLabel;
@property  (nonatomic, strong)  UILabel *viewHeightLabel;
@property  (nonatomic, strong) NSTimer *timer;
@property  (nonatomic,assign) CGFloat angle;
@property  (nonatomic,strong) UIImageView *imageView1;
@end

@implementation LearnVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initadsView];
    [self.view addSubview:self.demoImageView2];
    self.tabBarController.navigationItem.title = @"成长空间";
#pragma mark  设置tableBar 的字体大小 颜色 背景图片
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.2 blue:0.4 alpha:1];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f], NSForegroundColorAttributeName:[UIColor colorWithRed:90/255.0 green:38/255.0 blue:11/255.0 alpha:1]};//90 38 11
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
//
    NSArray *array = @[@"IMG_0123.JPG", @"IMG_0128.JPG", @"IMG_0132.JPG", @"IMG_0137.JPG"];
    [XNGuideView showGudieView:array];
    
//    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//    UIView *launchView = viewController.view;
//    UIImageView  * Imageview= [[UIImageView  alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [launchView addSubview:Imageview];
//    [self.view addSubview:launchView];
//    
//    //这一步是获取上次网络请求下来的图片，如果存在就展示该图片，如果不存在就展示本地保存的名为test的图片
//    NSMutableData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageu"];
//    if (data.length>0) {
//        Imageview.image = [UIImage imageWithData:data];
//    }else{
//        
//        Imageview.image = [UIImage imageNamed:@"Test"];
//    }
//    
//    
//    
//    //下面这段代码，是调用AFN下载文件的方法，异步
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSURL *URL = [NSURL URLWithString:@"http://s16.sinaimg.cn/large/005vePOgzy70Rd3a9pJdf&690"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//        
//        NSData * image = [NSData dataWithContentsOfURL:filePath];
//        [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"imageu"];
//        
//        
//    }];
//    [downloadTask resume];
//    
//
    
        
  
//    self.title = @"首页";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0.2 blue:0.4 alpha:1];
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f], NSForegroundColorAttributeName:[UIColor blackColor]};
//    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    //      [self startAnimation];
    
    //    self.nav = [[[UITabBarController alloc] initWithRootViewController:self.viewController] autorelease];
    //    [self.nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarMetrics:UIBarMetricsDefault];
  
    //   self.tabBarController.navigationItem.titleTextAttributes = [NSDictionarydictionaryWithObjectsAndKeys: [UIFontsystemFontOfSize:10.0f],NSFontAttributeName, nil];
    
    //    [_item setBackgroundImage:[UIImage imageNamed:@"suo1.png"] forState:UIControlStateNormal];
    //    [_item setBackgroundImage:[UIImage imageNamed:@"suo2.png"] forState:UIControlStateHighlighted];
    //    _item.frame = CGRectMake(0, fDeviceWidth-50, 20, 20);
    //    [self.view addSubview:_item];
    //    [self.view addSubview:self.collectionView];
    
    
    _dataSoure =[[DataManager shareInstance] getListenList];
    
    
   
    
#pragma mark  --- 页面选择 判断
     _BookSlectBtn.tag = 1;
    
    if (_BookSlectBtn.tag==2) {
        
        [self selectAdsAtIndex:2];
        
    }else{
        
        [self selectAdsAtIndex:1];
    
    }
    //    [self getShopPhotoMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"成长空间";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]  initWithTitle:@"锁" style:UIBarButtonItemStylePlain target:self action:@selector(clickLock)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = item;
    [MobClick beginLogPageView:@"LearnVC"];
//    if ((_BookSlectBtn.tag ==1)) {
//        
//        [self selectAdsAtIndex:2];
//    }
//    [self selectAdsAtIndex:1];
    //self.BookSlectBtn.hidden = YES;
    //    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"suo1.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"suo2.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.collectionView  reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
//    if ((_BookSlectBtn.tag  ==1)) {
// 
//        [self selectAdsAtIndex:2];
//    }
//    [self selectAdsAtIndex:1];
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
        // 调整cell 的大小
        layout.itemSize = CGSizeMake(width , width+20);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 66 * 2 + 30, 10);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, fDeviceWidth*0.29, self.view.frame.size.width, self.view.frame.size.height ) collectionViewLayout:layout];
        [_collectionView registerClass:[ListenCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (RecordingView *)recordView{
    if (!_recordView) {
        _recordView = [[RecordingView alloc] initWithFrame:CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height - 120)];
    }
    _recordView.VC = self;
    return _recordView;
}
- (void)setupBtnUI{
    
    _BookSlectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //     _BookSlectBtn.frame =CGRectMake(0, 120, fDeviceWidth-50 ,40);
    [_BookSlectBtn setImage:[UIImage imageNamed:@"创作7_03.png"] forState:UIControlStateNormal];
    // [_BookSlectBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_BookSlectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_BookSlectBtn addTarget:self action:@selector(SlectBook) forControlEvents:UIControlEventTouchUpInside];
    
    [_BookSlectBtn setTag:20];
    self.BookSlectBtn.userInteractionEnabled = YES;
    self.recordView.userInteractionEnabled = YES;
    [self.recordView addSubview:_BookSlectBtn];
    
    
//    if ([UIScreen mainScreen].bounds.size.width== 320){
//        
//        [_BookSlectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.recordView.mas_right).offset(-40);
//            make.bottom.equalTo(self.recordView.mas_top).offset(245);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//        }];
//        
//    }else{
    
    if ([UIScreen mainScreen].bounds.size.width== 320){
        [_BookSlectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //调整 右侧
            make.right.equalTo(self.recordView.mas_right).offset(-25);
            make.bottom.equalTo(self.recordView.mas_top).offset(205);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }else{
    
        [_BookSlectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //调整 右侧
            make.right.equalTo(self.recordView.mas_right).offset(-25);
            make.bottom.equalTo(self.recordView.mas_top).offset(245);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    
    }
//    }
    
}
-(void)SlectBook{
    BookVC *bVC= [[BookVC alloc]init];
    bVC.delegate = self;
    [self.navigationController pushViewController:bVC animated:YES];
    _BookSlectBtn.tag= 1;
    NSLog(@"点击了============");
}


- (LookView *)demoImageView2{
    if (!_demoImageView2) {
        
        _demoImageView2 = [[LookView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 100) image:[UIImage imageNamed:@"疯狂动物城.jpg"]];
        self.BookSlectBtn.hidden =YES;
    }
    return _demoImageView2;
}

-(void)clickLock{
    
    NSLog(@"锁住了");
    
    NSArray *timels = [NSArray arrayWithObjects:@"无限", @"60min", @"45min", @"30min",nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"护眼模式"
                                            rows:timels
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           // 选择以后做的事
                                           //      NSLog(@"Picker: %@, Index: %ld, value: %@",
                                           //         picker, (long)selectedIndex, selectedValue);
                                           
                                           // 不能使用睡眠模式
                                           //  [NSThread sleepForTimeInterval:3.0];
                                           
                                           
                                           if (selectedIndex ==0) {
                                               
                                               //
                                               //                                               _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(exitApp) userInfo:nil repeats:NO];
                                               
                                           }else if (selectedIndex == 1){
                                               
                                               _timer = [NSTimer scheduledTimerWithTimeInterval:3000.0 target:self selector:@selector(exitApp) userInfo:nil repeats:NO];
                                               
                                           }else{
                                               
                                               _timer = [NSTimer scheduledTimerWithTimeInterval:5000.0 target:self selector:@selector(exitApp) userInfo:nil repeats:NO];
                                               
                                           }
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         // 取消以后做的事
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
    
}


// 退出程序 动画
-(void)exitApp
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出本程序"  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        UIWindow *window = app.window;
        [UIView animateWithDuration:1.0f animations:^{
            window.alpha = 0.1;
            window.frame = CGRectMake(0, 0, window.bounds.size.height, 0);
        } completion:^(BOOL finished) {
            exit(0);
        }];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再玩会" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self.parentViewController presentViewController:alertController animated:YES completion:^{
        
    }];
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
    
    
    ListenCell *cell = (ListenCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.data = self.dataSoure[indexPath.row];
    
    //cell.listenData =self.dataSoure[indexPath.row];
    //    listenData.musicList = []
    
    
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    
    imageView1 = cell.imageView;
    
    //    cell.data = [xxx]
    
    
    
//    if(indexPath.row  == 0){
//        
//        [[PlayerManager defaultManager] playingMusic:@"ABC.mp3"];
//        //    [self runStar];
//        //    [self startAnimation];
//        
//    }else if (indexPath.row ==1){
//        
//        [[PlayerManager defaultManager] playingMusic:@"2015.mp3"];
//        
//    }else if (indexPath.row ==2){
//        
//        [[PlayerManager defaultManager] playingMusic:@"十二属相歌.mp3"];
//        
//    }else if (indexPath.row ==3){
//        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
//        
//    }else{
//        
//        [[PlayerManager defaultManager] playingMusic:@"五指歌.mp3"];
//    }
//    
}



- (void)runStar{
    
    ListenCell *cell = [[ListenCell alloc]init];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"chat_receiver_audio_playing001"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing002"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing003"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing004"],
                         [UIImage imageNamed:@"chat_receiver_audio_playing005"],nil];
    cell.musicView.animationImages = gifArray; //动画图片数组
    cell.musicView.animationDuration = 2; //执行一次完整动画所需的时长
    cell.musicView.animationRepeatCount = 500;  //动画重复次数
    [ cell.musicView startAnimating];
    
}

-(void) startAnimation
{
    ListenCell *cell = [[ListenCell alloc]init];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 2;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber  numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    [cell.imageView.layer addAnimation:animation forKey:@"transform.rotation.z"];
}

- (void)stopAnimation{
    ListenCell *cell = [[ListenCell alloc]init];
    [cell.imageView.layer removeAnimationForKey:@"transform.rotation.z"];
    
}



#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSoure.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ListenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.delegate = self;
    
    if (_selectIndexPath) {
        
        // 防止cell 重用  需要找到条件
        if (indexPath.row == _selectIndexPath.row ) {
            
            // cell.play.tag =1;
            [cell  startAnimation];
            [cell  runStar];
            cell.play.selected = YES;
            cell.play.tag = 1;
            
            //  [_oldCell.play setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
            _oldCell = cell;
            
        }else{
            
            // 取消 赋值tag  可以 修改状态
            cell.play.tag = 0;
            //            _oldCell = cell;
            [cell stopAnimation];
            [cell runstop];
            cell.play.selected = NO;
            //            cell.play.tag = 1;
            //              [_oldCell.play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
            
        }
    }
    
    
    cell.data = self.dataSoure[indexPath.row];
    return cell;
    
}




- (void)resetView{
    if (_selectIndex == 0) {
        [self.demoImageView2 removeFromSuperview];
        self.BookSlectBtn.hidden = YES;
    }else if (_selectIndex == 1){
        self.BookSlectBtn.hidden = YES;
        [self.collectionView removeFromSuperview];
        //self.BookSlectBtn.hidden = YES;
    }else if (_selectIndex == 2){
        [self.recordView  removeFromSuperview];
        
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
            [self setupBtnUI];
            
        }
    }
}

- (void)clickVideo{
    
    VideoVC *vc = [[VideoVC alloc] init];
    VideoEntity *video = [[VideoEntity alloc] init];
    // 电台连接
    video.mp4URL = @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
    vc.video = video;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
}
- (void)setBookIndexPath:(NSIndexPath *)bookIndexPath{
    _bookIndexPath = bookIndexPath;
    
    [self. recordView.collectionView reloadData];
    [self. recordView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

#pragma ListenCellDelegate
// 上一个cell 停止播放动画 和 旋转  oldcell = cell  在赋值过去
- (void)cellStopAnimationwithCell:(id)cell{
    
    if (_oldCell) {
        [_oldCell stopAnimation];
        [_oldCell runstop];
        // [self removecell];
        
        _oldCell.play.selected = NO;
        _oldCell.play.tag = 0;
        
    }
    
    [cell startAnimation];
    [cell runStar];
    _oldCell = cell;
    //    [_oldCell.play setImage:[UIImage imageNamed:@"guan1"] forState:UIControlStateNormal];
    NSIndexPath *path = [_collectionView indexPathForCell:cell];
    
    _selectIndexPath = path;
}

- (void)cellStopAnimation{
    
    //    [_oldCell.play setImage:[UIImage imageNamed:@"kai1"] forState:UIControlStateNormal];
    _selectIndexPath = nil;
    _oldCell = nil;
}





////清楚cell的缓存
//- (void)removecell{
//    NSArray *subviews = [[NSArray alloc] initWithArray:_oldCell.contentView.subviews];
//    for (UIView *subview in subviews) {
//        [subview removeFromSuperview];
//    }
//}

@end
