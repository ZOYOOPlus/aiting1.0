//
//  XiaoxiNewsVC.m
//  baobei
//
//  Created by 张源海 on 16/7/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "XiaoxiNewsVC.h"

@interface XiaoxiNewsVC ()

@end

@implementation XiaoxiNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"活动";
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backVC)];
    self.navigationItem.leftBarButtonItems = @[item1];

}

- (void)backVC{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
