//
//  CreatView.m
//  baobei
//
//  Created by 张源海 on 16/7/16.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "CreatView.h"
#import "HCommon.h"
// 一张图的cell
#import "HImageListCell.h"
#import "PaintFullVC.h"
#define IMG_COUNT  3
//static  NSString *cellID = @"IMG";

static CGFloat kBannerHeight = 150.0f;
static CGFloat kHeadHeight = 30.f;

static NSString *cellId = @"cellD";
@interface CreatView ()<UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *BannerPhontoArray;
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)NSArray *photoArray;
@property (nonatomic,strong)UILabel  *TishiLabel;
@property (nonatomic,strong)UILabel  *pingLabel;

@property (nonatomic, assign) NSInteger selectType;

@end

@implementation CreatView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectType = 1;
    [self setupUI];
    [self.view addSubview:self.collectionView];
    
}
-(void)setupUI{

    _TishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-75,self.view.bounds.size.width+10, 150, 60)];
     _TishiLabel.textAlignment = UITextAlignmentCenter;
    
    _TishiLabel.text = @"  ← 左右滑动选择 → ";
    [self.TishiLabel sizeToFit];
    [self.view  addSubview:_TishiLabel];

    _pingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, fDeviceWidth-30, fDeviceWidth, 5)];
    _pingLabel.text = @"__________________________________________________________";
    
    [self.pingLabel sizeToFit];
    [self.view addSubview:_pingLabel];

}
+ (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //    CGFloat itemWidth = [[self class] contentHeight];
    flowLayout.itemSize = CGSizeMake(300,300);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, (screenWidth - 300)/2, 0, (screenWidth - 300)/2);
    flowLayout.minimumLineSpacing = (screenWidth - 300);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,188+20 ) collectionViewLayout:[[self class] getFlowLayout]];
        _collectionView = [[UICollectionView  alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.width-20) collectionViewLayout:[[self class] getFlowLayout]];
        [_collectionView registerClass:[HImageListCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    // 传值过去
    
    PaintFullVC *PVC = [[PaintFullVC alloc]init];
        HImageListCell *cell = (HImageListCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];

        PVC.icon = cell.imageView.image;

    [self.navigationController pushViewController:PVC animated:YES];
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count;
    switch (self.trailIndex) {
        case 0:
            count = 6;
            break;
        case 1:
            count = 12;
            break;
            case 2:
            count = 16;
            case 3:
            count =15;
        case 4:
            count= 7;
        default:
            break;
    }
        return count;
//    return self.imgs.count;
}
// 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
       HImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
   
            
                NSString *imgStr = [NSString stringWithFormat:@"Map0%zd_%zd.jpg", indexPath.row+1, self.trailIndex];
                cell.imageView.image = [UIImage imageNamed:imgStr];
    
    DLog(@"testest");
    return cell;
}

- (void)clickHeadButton:(id)sender{
    self.selectType = [sender tag];
}

- (void)setSelectType:(NSInteger)selectType{
    if (_selectType == selectType) {
        return;
    }
    _selectType = selectType;
    [self.collectionView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"列表";

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
