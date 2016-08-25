//
//  ShowDao.h
//  baobei
//
//  Created by 张源海 on 16/8/6.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowDao : NSObject
+ (void)getShowPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail;
@end
