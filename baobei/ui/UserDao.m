//
//  UserDao.m
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "UserDao.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UserModel.h"
@implementation UserDao
+(void)getUserPhotoWithUserId:(NSString *)useid sucess:(void (^)(NSArray *))sucess fail:(void (^)())fail {
    
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                UserModel *model = [[UserModel alloc] initWithObject:object];
                [arrayM addObject:model];
                NSLog(@"%@",model);
            }
            sucess(arrayM);
        }
    }];
}

@end
