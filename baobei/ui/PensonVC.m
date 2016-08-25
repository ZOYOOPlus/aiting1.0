//
//  PensonVC.m
//  baobei
//
//  Created by 张源海 on 16/7/21.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "PensonVC.h"


#import "LoginVC.h"
#import "AvatarCell.h"
#import "RegistVC.h"
#import "ShopVC.h"

#import "HWebView.h"
#import "DataManager.h"

#import "SettingVC.h"
#import "UserDao.h"
#import "UserModel.h"
#import "UserCell.h"
#import "ReviseVC.h"
#import "VIPVC.h"
#import "MyGold.h"
#import "LotteryVC.h"


@interface PensonVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic,strong)UIView *aView;
@property (nonatomic,strong)UIImageView  *imageView;
@property (nonatomic,strong)NSMutableArray *groups;
@property (nonatomic,strong)UIButton *iconBtn;
@property (nonatomic,strong)NSArray  *UserPhoAAy;
@property  (nonatomic,strong)UIButton *JiangBtn;


@end

@implementation PensonVC
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewCellStyleValue2;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([AVUser currentUser] == NULL){
        LoginVC *loVC = [[LoginVC  alloc]init];
        [self.navigationController pushViewController:loVC animated:YES];
    }else{
    }
    
    self.tabBarController.navigationItem.title = @"我的";
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]  initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share3Click)];
    self.tabBarController.navigationItem.rightBarButtonItem = item2;
    
    
    
    self.groups = [NSMutableArray array];
    
    
    
    self.tableView.backgroundColor = [UIColor  colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    //    _LoginName = [
    //    [[AVUser  currentUser]username] substringFromIndex:7];
    //    NSLog( @"%@",_LoginName);
    [self setExtraCellLineHidden:self.tableView];
    [self setlayoutHeaderView];
    [self loadDataSource];
    [self setupUI];
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)share3Click{
    
}
-(void)viewDidLayoutSubviews
{
    // 重写UITableView的方法是分割线从最左侧开始
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView  setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView  respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView  setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

// 隐藏多余显示的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

-(void)setupUI{
    
    _iconBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_iconBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [_iconBtn setTag:21];
    _iconBtn.layer.cornerRadius = 50*0.6;
    _iconBtn.layer.masksToBounds = true;
    _iconBtn.layer.borderWidth = 0.0;
    [self.tableView addSubview:_iconBtn];
    
    
    
    // 添加 “奖”
    _JiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_JiangBtn setTitle:@"奖" forState:UIControlStateNormal];
    [_JiangBtn setImage:[UIImage imageNamed:@"抽奖8_5.png"] forState:UIControlStateNormal];
    [_JiangBtn addTarget:self action:@selector(Lottery) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView  addSubview:_JiangBtn];
    
    [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/2-50*0.6);
        make.bottom.equalTo(self.imageView.mas_top).offset(140);
        make.size.mas_equalTo(CGSizeMake(100*0.6, 100*0.6));
    }];
    
    
    [_JiangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/2+120);
        make.bottom.equalTo(self.imageView.mas_top).offset(170);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _Userimager = [[UIImageView alloc]init];
    _Userimager.layer.cornerRadius = 50*0.6;
    // _Userimager.image = [UIImage imageNamed:@"01.png"];
    [self.tableView addSubview:_Userimager];
    [_Userimager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/2-50*0.6);
        make.bottom.equalTo(self.imageView.mas_top).offset(140);
        make.size.mas_equalTo(CGSizeMake(100*0.6, 100*0.6));
    }];
    
    
    _UserName = [[UILabel  alloc]init];
    [_UserName setTextColor:[UIColor  blackColor]];
    _UserName.textAlignment = UITextAlignmentCenter;
    [self.tableView addSubview:_UserName];
    [self.UserName sizeToFit];
    [_UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/2-60);
        make.bottom.equalTo(self.imageView.mas_top).offset(175);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    
}

- (void)Lottery
{
    
    LotteryVC *loVC = [[LotteryVC alloc]init];
    [self.navigationController pushViewController:loVC animated:YES];
    
}
-(void)LoginClick
{
    
    if([AVUser currentUser] != NULL){
        ReviseVC  *reVC = [[ReviseVC  alloc]init];
        [self.navigationController pushViewController:reVC animated:YES];
    }else{
        
        LoginVC *LogVC = [[LoginVC alloc]init];
        [self.navigationController pushViewController:LogVC animated:YES];
    }
    
}
- (void)loadDataSource{
    //获取个人中心数据
    self.dataSource = [[DataManager shareInstance] getProfileConfigArray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)setlayoutHeaderView{
    //设置一个view,为了使将图片添加到这个view上
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    //添加图片
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    self.imageView.image = [UIImage imageNamed:@"888.jpg"];
    [aView addSubview:self.imageView];
    self.tableView.tableHeaderView = aView;
    
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取偏移量
    CGPoint offset = scrollView.contentOffset;
    //判断是否改变
    if (offset.y < 0) {
        CGRect rect = self.imageView.frame;
        //我们只需要改变图片的y值和高度即可
        rect.origin.y = offset.y;
        rect.size.height = 180 - offset.y;
        _imageView.frame = rect;
    }
}
#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    NSMutableDictionary *sectionDictionary = self.dataSource[section][row];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if(indexPath.section == 0 && indexPath.row == 0){
            //  cell = [[AvatarCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
            //  cell.backgroundColor =[UIColor  orangeColor];
            
            
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }if (indexPath.section == 2 && indexPath.row == 0) {
        
        // 设置一行为空  达到分组的效果
        cell.backgroundColor = [UIColor  colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        
        cell.accessoryType =  UITableViewCellAccessoryNone;
        //        cell.detailTextLabel.text = @"mona";
    }
    
    NSString *title = [sectionDictionary valueForKey:@"title"];
    NSString *imageName = [sectionDictionary valueForKey:@"image"];
    
    if (title) {
        cell.textLabel.text = title;
    }
    if (imageName) {
        
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

#pragma markr - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        default: {
            return 3;
            break;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        
        
        return 20;
        
    }else{
        if ([UIScreen mainScreen].bounds.size.width == 320) {
            
            return 50;
        }else{
            return 60;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSMutableArray *section = [[NSMutableArray alloc] initWithCapacity:1];
        //个人信息
        if([AVUser currentUser] != NULL){
            
            SettingVC *setVC = [[SettingVC alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
            
        }else{
            LoginVC *login = [[LoginVC alloc] init];
            [self.tabBarController.navigationController pushViewController:login animated:YES];
        }
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        RegistVC *regist = [[RegistVC alloc] init];
        [self.tabBarController.navigationController pushViewController:regist animated:YES];
        
        
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        //当前@币
        
        MyGold *myVC = [[MyGold alloc]init];
        [self.tabBarController.navigationController pushViewController:myVC animated:YES];
        
        
    } else if (indexPath.section == 1 && indexPath.row == 1){
        //兑换
        
        ShopVC *shop = [[ShopVC alloc]init];
        [self.tabBarController.navigationController pushViewController:shop animated:YES];
        
        
    } else if (indexPath.section == 1 && indexPath.row == 2){
        //VIP 任务
        
        VIPVC *vIPVC = [[VIPVC alloc]init];
        [self.tabBarController.navigationController pushViewController:vIPVC animated:YES];
        
        
        //    } else if (indexPath.section == 2 && indexPath.row == 3){
        //        //我的收藏
        
    } else if (indexPath.section == 2 && indexPath.row == 0){
        
        
        
        
        
        
        
    } else if (indexPath.section == 2 && indexPath.row == 2){
        
        SettingVC *spVC = [[SettingVC alloc]init];
        [self.navigationController  pushViewController:spVC animated:YES];
        [self loadDataSource];
        [self.tableView reloadData];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.navigationItem.title = @"我的";
    if ([AVUser currentUser]== NULL) {
        _UserName.text = @"请登录";
        _Userimager.image = [UIImage imageNamed:@"jm.jpg"];
    }else
    {
        //        _UserName.text = [NSString stringWithFormat:@"@Dream%@",_LoginName];
        _UserName.text = [[AVUser currentUser]objectForKey:@"name"] ;
        //        _Userimager.image = [[AVUser  currentUser]objectForKey:@"userphoto"];
        AVFile* imageFile = [[AVUser currentUser]objectForKey:@"userphoto"];
        NSURL *url2 = [NSURL URLWithString:imageFile.url];
        
        _Userimager.layer.masksToBounds = YES; //没这句话它圆不起来
        _Userimager.layer.cornerRadius = 50.0*0.6; //设置图片圆角的尺度
        [_Userimager sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"01"]];
        
    }
    
    [self loadDataSource];
    [self.tableView  reloadData];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self.UserName resignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.UserName  resignFirstResponder];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//
//}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
        //做自己想做的事
        return NO;
    }
    return YES;
    
}

@end
