//
//  BaseVC.h
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"
#import <MBProgressHUD/MBProgressHUD.h>
//#import <MBProgressHUD/>
@interface BaseVC : UIViewController
/// alertView
- (void)showAlertView:(NSString *)title content:(NSString *)content;

/// 加载转轮
- (void)showProgressView:(NSString *)message;
/// 取消加载转轮
- (void)hidenProgress;
@end
