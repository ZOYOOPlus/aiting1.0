//
//  YHProvincialCitiesCountiesPickerview.h
//  baobei
//
//  Created by 张源海 on 16/8/3.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHProvincialCitiesCountiesPickerview : UIView

@property (nonatomic,copy)void(^completion)(NSString *provinceName,NSString *cityName,NSString *countyName);

// 显示  省市县 名
- (void)showPickerWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName countyName:(NSString *)countyName;

@end
