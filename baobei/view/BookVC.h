//
//  BookVC.h
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BaseVC.h"
#import "HCommon.h"
#import "LearnVC.h"
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)

#define kItemWidthHeigthScale 1.2  //长宽比
@interface BookVC : BaseVC

@property (strong , nonatomic)LearnVC * delegate;

//-(void)imageQueryBooks;
@end
