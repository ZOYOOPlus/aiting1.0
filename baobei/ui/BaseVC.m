//
//  BaseVC.m
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertView:(NSString *)title content:(NSString *)content{
    UIAlertView *alery = [[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    for (UIView *tempView in alery.subviews) {
        
        if ([tempView isKindOfClass:[UILabel class]]) {
            // 当该控件为一个 UILabel 时
            UILabel *tempLabel = (UILabel *) tempView;
            tempLabel.font = [UIFont systemFontOfSize:16];
            if ([tempLabel.text isEqualToString:alery.title]) {
                // 调整字体大小
                tempLabel.font = [UIFont systemFontOfSize:16];
            }
        }
        if ([tempView isKindOfClass:[UIButton class]]) {
            // 当该控件为一个 UILabel 时
            UIButton *tempLabel = (UIButton *) tempView;
            tempLabel.titleLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    [alery show];
}
- (void)showProgressView:(NSString *)message{
    MBProgressHUD *pro = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    pro.labelFont = [UIFont systemFontOfSize:15];
    pro.labelText = message;
    [self.view bringSubviewToFront:self.navigationController.navigationBar];
}
- (void)hidenProgress{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
