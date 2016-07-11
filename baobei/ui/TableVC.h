//
//  TableVC.h
//  jyt
//
//  Created by 贺少虎 on 16/4/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//  全屏tableView 页面

#import <UIKit/UIKit.h>

@interface TableVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (strong, nonatomic) NSMutableArray * dataSource;

@end
