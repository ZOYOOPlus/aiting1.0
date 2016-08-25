//
//  NewsVC.m
//  baobei
//
//  Created by 张源海 on 16/7/12.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "NewsVC.h"
#import "NewsCell.h"
#import "LoginVC.h"
#import "XiaoxiNewsVC.h"
#import "DianzanVC.h"
#import "liuyanVC.h"
#import "VIPVC.h"
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)

static float AD_height = 150;//广告栏高度

@interface NewsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UIButton  *aiteViewButton;

@property (nonatomic,strong)UIImageView *aiteImage1;
@property (nonatomic,strong)UIImageView *aiteImage2;
@property (nonatomic,strong)UIView  *blackView1;
@property  (nonatomic,strong)UILabel  *aitelabel1;
@property  (nonatomic,strong)UILabel  *aitelabel2;

@property  (nonatomic,strong)UIButton  *leavemesaageBtn;

@property (nonatomic,strong)UIImageView *leaveImage1;
@property (nonatomic,strong)UIImageView *leavemage2;
@property (nonatomic,strong)UIView  *blackView2;
@property  (nonatomic,strong)UILabel  *leaveLabel1;
@property  (nonatomic,strong)UILabel  *leaveLabel2;

@property  (nonatomic,strong )UIButton  *zanViewBtn;
@property (nonatomic,strong)UIImageView *zanImage1;
@property (nonatomic,strong)UIImageView *zanmage2;
@property (nonatomic,strong)UIView  *blackView3;
@property (nonatomic,strong)UILabel  *zanLabel1;
@property (nonatomic,strong )UILabel *zanLabel2;

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation NewsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([AVUser currentUser] == NULL){
        LoginVC *loVC = [[LoginVC  alloc]init];
        [self.navigationController pushViewController:loVC animated:YES];
    }else{
    }
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backVC)];
//    self.tabBarController.navigationItem.leftBarButtonItems = @[item1];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:238.0/255.0 blue:239.0/255.0 alpha:1];
   self.tabBarController.navigationItem.title = @"VIP任务";
    
    [self setup];
    [self setup2];
    [self setup3];
    
    [self.view addSubview:self.collectionView];
    
  
}
- (void)backVC{
    
        [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
          self.tabBarController.navigationItem.title = @"VIP任务";
    //[self reloadInputViews];
}

#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+10);//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 210, fDeviceWidth,fDeviceHeight/2.6) collectionViewLayout:flowLayout];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((fDeviceWidth-20)/2, (fDeviceWidth-20)/2+50);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 5;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //背景颜色
        _collectionView.backgroundColor = [UIColor clearColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}

-(void)setup{
    
    _aiteViewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    _aiteViewButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _aiteViewButton];
    [_aiteViewButton addTarget:self action:@selector(newsClick) forControlEvents:UIControlEventTouchUpInside];
    
    _aiteImage1 = [[UIImageView alloc]init];
    _aiteImage1.image = [UIImage imageNamed:@"01.png"];
    [self.view  addSubview:_aiteImage1];
    _aiteImage2 = [[UIImageView alloc]init];
    _aiteImage2.image = [UIImage imageNamed:@"消息7_13_03.png"];
    [self.view addSubview:_aiteImage2];
    _aitelabel1 = [[UILabel alloc]init];
    _aitelabel1.text = @"官方任务";
    _aitelabel1.textColor = [UIColor orangeColor];
  //  [_aitelabel1 setTintColor:[UIColor orangeColor]];
    [self.view addSubview:_aitelabel1];
    _aitelabel2 = [[UILabel alloc]init];
  //  _aitelabel2.text = @"开通会员更多优惠";
    [self.view addSubview:_aitelabel2];
    _blackView1 = [[UIView alloc]init];
    _blackView1.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:238.0/255.0 blue:239.0/255.0 alpha:1];
    [self.view  addSubview:_blackView1];
    
    
    [_aiteImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(8);
        make.bottom.equalTo(self.view.mas_top).offset(64);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_aiteImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_top).offset(44);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [_aitelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aiteImage1.mas_right).offset(20);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 18));
        NSLog(@"label1");
        
    }];
    
    [_aitelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aiteImage1.mas_right).offset(20);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.size.mas_equalTo(CGSizeMake(150, 18));
        
    }];
    
    [_blackView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(2);
         make.top.equalTo(self.aiteImage1.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, 10));
        
    }];
}


-(void)setup2{
    
    _leavemesaageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 70)];
    _leavemesaageBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _leavemesaageBtn];
    [_leavemesaageBtn addTarget:self action:@selector(newsClick2) forControlEvents:UIControlEventTouchUpInside];
    _leaveImage1 = [[UIImageView alloc]init];
    _leaveImage1.image = [UIImage imageNamed:@"02.png"];
    [self.view  addSubview:_leaveImage1];
    _leavemage2 = [[UIImageView alloc]init];
    _leavemage2.image = [UIImage imageNamed:@"消息7_13_03.png"];
    [self.view addSubview:_leavemage2];
    _leaveLabel1 = [[UILabel alloc]init];
    _leaveLabel1.text = @"留言";
    _leaveLabel1.textColor = [UIColor orangeColor];
    [self.view addSubview:_leaveLabel1];
    _leaveLabel2 = [[UILabel alloc]init];
    //_leaveLabel2.text = @"开通会员更多优惠";
    [self.view addSubview:_leaveLabel2];
    _blackView2 = [[UIView alloc]init];
    _blackView2.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:238.0/255.0 blue:239.0/255.0 alpha:1];
  //  _blackView2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_blackView2];
    
    [_leaveImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(8);
        make.top.equalTo(self.view.mas_top).offset(self.aiteViewButton.height+5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_leavemage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
       make.top.equalTo(self.view.mas_top).offset(self.aiteViewButton.height+35);        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [_leaveLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leaveImage1.mas_right).offset(20);
        make.bottom.equalTo(self.blackView2.mas_top).offset(-25);
        make.size.mas_equalTo(CGSizeMake(100, 18));
        NSLog(@"label1");
    }];
    [_leaveLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leaveImage1.mas_right).offset(20);
        make.top.equalTo(self.blackView1.mas_top).offset(40);
         //make.top.equalTo(self.blackView2.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 18));
    
    }];
 
    [_blackView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(2);
          make.top.equalTo(self.leaveImage1.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, 5));
        
    }];

}



-(void)setup3{
    
    _zanViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 142, self.view.bounds.size.width, 70)];
    _zanViewBtn.backgroundColor = [UIColor whiteColor];
 
    [self.view addSubview: _zanViewBtn];
    [_zanViewBtn addTarget:self action:@selector(newsClick3) forControlEvents:UIControlEventTouchUpInside];
    _zanImage1 = [[UIImageView alloc]init];
    _zanImage1.image = [UIImage imageNamed:@"03.png"];
    [self.view  addSubview:_zanImage1];
    _zanmage2 = [[UIImageView alloc]init];
    _zanmage2.image = [UIImage imageNamed:@"消息7_13_03.png"];
    [self.view addSubview:_zanmage2];
    _zanLabel1 = [[UILabel alloc]init];
    _zanLabel1.text = @"点赞";
    _zanLabel1.textColor = [UIColor  orangeColor];
    [_zanLabel1 setTintColor:[UIColor orangeColor]];
    [self.view addSubview:_zanLabel1];
    _zanLabel2 = [[UILabel alloc]init];
 //   _zanLabel2.text = @"开通会员更多优惠";
    [self.view addSubview:_zanLabel2];
    _blackView3 = [[UIView alloc]init];
    _blackView3.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:238.0/255.0 blue:239.0/255.0 alpha:1];
    [self.view  addSubview:_blackView3];
    
    [_zanImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(8);
        make.top.equalTo(self.blackView2.mas_top).offset(4);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_zanmage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
       make.top.equalTo(self.blackView2.mas_bottom).offset(22);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [_zanLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zanImage1.mas_right).offset(20);
        make.top.equalTo(self.blackView2.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 18));
        NSLog(@"label1");
    }];
    
    [_zanLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leaveImage1.mas_right).offset(20);
        make.top.equalTo(self.zanImage1.mas_top).offset(40);
        make.size.mas_equalTo(CGSizeMake(150, 18));
        
    }];
    
    [_blackView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(2);
        make.top.equalTo(self.zanImage1.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, 5));
        
    }];
}
-(void)newsClick{
    if([AVUser currentUser] == NULL){
    LoginVC *loVC = [[LoginVC  alloc]init];
    [self.navigationController pushViewController:loVC animated:YES];
    }else {
//        XiaoxiNewsVC  *xiaoVC = [[XiaoxiNewsVC  alloc]init];
//        [self.navigationController pushViewController:xiaoVC animated:YES];
        VIPVC  *vip = [[VIPVC  alloc]init];
        [self.navigationController pushViewController:vip animated:YES];
    }
}

-(void)newsClick2{
    if([AVUser currentUser] == NULL){
        LoginVC *loVC = [[LoginVC  alloc]init];
        [self.navigationController pushViewController:loVC animated:YES];
    }else {
        liuyanVC  *xiaoVC = [[liuyanVC  alloc]init];
        [self.navigationController pushViewController:xiaoVC animated:YES];
    }
}

-(void)newsClick3{
    if([AVUser currentUser] == NULL){
        LoginVC *loVC = [[LoginVC  alloc]init];
        [self.navigationController pushViewController:loVC animated:YES];
    }else {
        DianzanVC  *xiaoVC = [[DianzanVC  alloc]init];
        [self.navigationController pushViewController:xiaoVC animated:YES];
    }
}

#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    return cell;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }
- (void)viewWillAppear:(BOOL)animated
{
//    if([AVUser currentUser] == NULL){
//        LoginVC *loVC = [[LoginVC  alloc]init];
//        [self.navigationController pushViewController:loVC animated:YES];
//    }else{
//    }
}
@end
