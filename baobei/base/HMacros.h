//
//  HMacros.h
//  demo
//
//  Created by 贺少虎 on 16/4/8.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#ifndef HMacros_h
#define HMacros_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define WEAKSELF  typeof(self) __weak weakSelf=self;

#define RGB(R,G,B) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]
#define RGBA(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)/255]

#define LOCAL_COLOR [NSMutableArray arrayWithObjects:RGB(236, 11, 25),RGB(251, 160, 40),RGB(254, 244, 40), nil]

// 青苗绿
#define QMHRGB RGB(145, 201, 122)
// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

#define APP_FONT @"YouYuan"

#endif /* HMacros_h */
