//
//  UpdateVC.m
//  baobei
//
//  Created by 张源海 on 16/7/18.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "UpdateVC.h"

@interface UpdateVC ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImage *editedImage;
    NSString *_imageUrl;
}

@property (strong, nonatomic) UITableView *myTableView;
@end

@implementation UpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
