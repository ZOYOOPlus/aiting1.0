//
//  BannerDao.h
//  baobei
//
//  Created by 张源海 on 16/7/11.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerDao : NSObject
+ (void)getBannerPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;
@end
