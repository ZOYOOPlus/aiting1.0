//
//  BookDao.h
//  baobei
//
//  Created by 张源海 on 16/8/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BookDao : NSObject
#pragma mark  不同的网络请求
// book 书 的名字
+ (void)getBookPhotoWithUserid:(NSString *)userid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;

#pragma mark  不同的网络请求
// 萤火小英雄
+ (void)getYinghuoPhotoWithUserid:(NSString *)userid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;

// 天外来客
+ (void)getTianwaiPhotoWithUserid:(NSString *)userid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;

// 保卫家园
+ (void)getBaoweiPhotoWithUserid:(NSString *)userid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;

// 奇妙的海底世界
+ (void)getQimiaoPhotoWithUserid:(NSString *)userid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;



@end
