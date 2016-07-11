//
//  ProfileVC.m
//  jyt
//
//  Created by 贺少虎 on 16/4/13.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ProfilesVC.h"

#import "DataManager.h"
#import "LoginVC.h"
#import "AvatarCell.h"
#import "RegistVC.h"

@implementation ProfilesVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadDataSource];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.tabBarController.navigationItem.backBarButtonItem = item;
    self.tabBarController.navigationItem.title = @"我的";
    [self loadDataSource];
    [self.tableView reloadData];
}

- (void)loadDataSource{
    //获取个人中心数据
    self.dataSource = [[DataManager shareInstance] getProfileConfigArray];
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
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if(indexPath.section == 0 && indexPath.row == 0){
            cell = [[AvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title = [sectionDictionary valueForKey:@"title"];
    NSString *imageName = [sectionDictionary valueForKey:@"image"];
    
    if (title) {
        cell.textLabel.text = title;
    }
    if (imageName) {
        cell.imageView.image = [UIImage imageNamed:imageName];
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
            return 14;
            break;
        default: {
            return 4;
            break;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        //个人信息
        if([AVUser currentUser] != NULL){
            
        }else{
            LoginVC *login = [[LoginVC alloc] init];
            [self.tabBarController.navigationController pushViewController:login animated:YES];
        }
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        RegistVC *regist = [[RegistVC alloc] init];
        [self.tabBarController.navigationController pushViewController:regist animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        //查看物流
        
    } else if (indexPath.section == 1 && indexPath.row == 1){
        //查看订单
        
    } else if (indexPath.section == 1 && indexPath.row == 2){
        //我的优惠劵
        
    } else if (indexPath.section == 1 && indexPath.row == 3){
        //我的收藏
        
    } else if (indexPath.section == 2 && indexPath.row == 0){
        //系统设置
    } else if (indexPath.section == 2 && indexPath.row == 1){
        //系统设置
        [AVUser logOut];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NULL message:@"退出登录成功！" delegate:NULL cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
        [self loadDataSource];
        [self.tableView reloadData];
    }
}

@end
