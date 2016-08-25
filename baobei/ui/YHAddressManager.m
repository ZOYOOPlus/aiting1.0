//
//  YHAddressManager.m
//  baobei
//
//  Created by 张源海 on 16/8/3.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "YHAddressManager.h"

@interface YHAddressManager ()

@end

@implementation YHAddressManager

// 类方法  单例方法
+ (instancetype)shareInstance{
    static YHAddressManager *_addressManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{
        _addressManager = [[self alloc]init];
 });
    return _addressManager;
}

// 加载plist 文件
- (NSArray *)provinceDicAry{
    if (!_provinceDicAry) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _provinceDicAry = [[NSArray alloc]initWithContentsOfFile:path];
    }
    return _provinceDicAry;
}


@end
