//
//  YHAddressManager.h
//  baobei
//
//  Created by 张源海 on 16/8/3.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAddressManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,strong) NSArray *provinceDicAry;//省字典数组

#define kAddressManager [YHAddressManager shareInstance]

@end
