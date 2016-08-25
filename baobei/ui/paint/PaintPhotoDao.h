//
//  PaintPhotoDao.h
//  baobei
//
//  Created by 张源海 on 16/7/19.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaintPhotoDao : NSObject
+ (void)getPaintPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;
@end
