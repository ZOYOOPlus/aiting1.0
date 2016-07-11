//
//  BaseCollectionViewVC.h
//  baobei
//
//  Created by 贺少虎 on 16/5/16.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"

@interface BaseCollectionViewVC : UIViewController

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end
