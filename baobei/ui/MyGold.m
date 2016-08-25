//
//  MyGold.m
//  baobei
//
//  Created by 张源海 on 16/8/4.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "MyGold.h"

@interface MyGold () <UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property  (nonatomic,strong) UILabel   *aiteBi;

@end

@implementation MyGold

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewCellStyleValue2;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExtraCellLineHidden:self.tableView];
    self.title = @"我的金币";
    [self setupUI];
}

-(void)setupUI{
    
    
}


// 隐藏多余显示的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1){
        return 40;
    }else{
    return 60;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark  --- 设置table行数
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //    cell.detailTextLabel.text=@"100";
    //    [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
    
    if (cell == nil)
    {
        //cell.imageView.image = [UIImage imageNamed:@"抽奖8_5.png"];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"monalisa";
    }
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.detailTextLabel.text = @"mona";
    if (indexPath.row == 0)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:@"cell"];
        
        cell.textLabel.text = @"账户余额:";
        // 设置cell 的颜色
        [cell.textLabel setTextColor:[UIColor orangeColor]];
        
        UILabel *Goldlabel = [[UILabel  alloc]initWithFrame:CGRectMake(100, 0, 100, 60)];
        Goldlabel.text = @"160";
        Goldlabel.textColor = [UIColor orangeColor];
        [self.tableView addSubview:Goldlabel];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-(fDeviceWidth*0.24), 0, 100, 60)];
        label.text = @"记录";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];

        
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"充值：";
        // 设置cell 的颜色
        [cell.textLabel setTextColor:[UIColor brownColor]];
        cell.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    }
    else if (indexPath.row == 2)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIImageView *imageCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 115, 30, 30)];
        [self.tableView addSubview:imageCell];
        imageCell.image = [UIImage imageNamed:@"抽奖8_5.png"];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 60)];
        label.text = @"30";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame  = CGRectMake(fDeviceWidth-(fDeviceWidth*0.25), 120, 60, 30);
    
 
        [button setTitle:@"¥3" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor  orangeColor] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self.tableView addSubview:button];
        
    }
    
    else if (indexPath.row == 3)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIImageView *imageCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 175, 30, 30)];
        [self.tableView addSubview:imageCell];
        imageCell.image = [UIImage imageNamed:@"抽奖8_5.png"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 160, 100, 60)];
        label.text = @"60";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame  = CGRectMake(fDeviceWidth-(fDeviceWidth*0.25), 180, 60, 30);
        
        
        [button setTitle:@"¥6" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor  orangeColor] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self.tableView addSubview:button];

        
    }
    else if (indexPath.row == 4)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIImageView *imageCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 235, 30, 30)];
        [self.tableView addSubview:imageCell];
        imageCell.image = [UIImage imageNamed:@"抽奖8_5.png"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 220, 100, 60)];
        label.text = @"100";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame  = CGRectMake(fDeviceWidth-(fDeviceWidth*0.25), 240, 60, 30);
        
        
        [button setTitle:@"¥10" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor  orangeColor] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self.tableView addSubview:button];
    }
    else if (indexPath.row == 5)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIImageView *imageCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 295, 30, 30)];
        [self.tableView addSubview:imageCell];
        imageCell.image = [UIImage imageNamed:@"抽奖8_5.png"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 280, 100, 60)];
        label.text = @"150";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame  = CGRectMake(fDeviceWidth-(fDeviceWidth*0.25), 300, 60, 30);
      
        
        [button setTitle:@"¥15" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor  orangeColor] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self.tableView addSubview:button];
    }
    else if (indexPath.row == 6)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIImageView *imageCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 355, 30, 30)];
        [self.tableView addSubview:imageCell];
        imageCell.image = [UIImage imageNamed:@"抽奖8_5.png"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 340, 100, 60)];
        label.text = @"200";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame  = CGRectMake(fDeviceWidth-(fDeviceWidth*0.25), 360, 60, 30);
        
        
        [button setTitle:@"¥20" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor  orangeColor] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:[UIColor orangeColor].CGColor];
        

        
        [self.tableView addSubview:button];
    }


    
    return cell;
    
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

