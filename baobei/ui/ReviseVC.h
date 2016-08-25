//
//  ReviseVC.h
//  baobei
//
//  Created by 张源海 on 16/7/30.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "TableVC.h"
#import "HCommon.h"

@interface ReviseVC : TableVC
@property  (nonatomic,strong) UITextField   *UserdName;
@property  (nonatomic,strong) UILabel *UserdAge;
@property  (nonatomic,strong) UILabel  *UserdPhone;
@property  (nonatomic,strong) UITextField   *UserdCName;
@property  (nonatomic,strong) UILabel   *UserdSex;
@property  (nonatomic,strong) UILabel  *UserdBrithday;
@property  (nonatomic,strong) UILabel  *UserdAddress;


//// 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
//
//- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
//
//// 将rect从view中转换到当前视图中，返回在当前视图中的rect
//
//- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

@end
