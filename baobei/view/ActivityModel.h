//
//  ActivityModel.h
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat kActivityImageHeight = 80;
static CGFloat kActivityImageWidth = 110;


@interface ActivityModel: NSObject
// 头条的属性
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *media_name;
//@property (nonatomic, strong) NSDate *publisDate;
//@property (nonatomic, copy) NSMutableArray *image_list;
//@property (nonatomic, strong) NSString *display_url;
//@property (nonatomic,strong)NSMutableArray *middle_image;

// 本地加载
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSDate *publisDate;
@property (nonatomic, copy) NSMutableArray *imageList;
@property (nonatomic, strong) NSString *displayURL;
//@property (nonatomic,strong)
// 处理Json 时 显示
- (void)setPublisDateWithTimestamp:(NSTimeInterval)timestamp;
//- (instancetype)iniTWithDict:(NSDictionary *)dict;

//不处理显示


@end
