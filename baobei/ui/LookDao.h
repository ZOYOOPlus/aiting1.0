//
//  LookDao.h
//  baobei
//
//  Created by 张源海 on 16/8/14.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookDao : NSObject
+ (void)getLookPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;
@end
