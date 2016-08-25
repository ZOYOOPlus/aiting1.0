//
//  LookDao.m
//  baobei
//
//  Created by 张源海 on 16/8/14.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LookDao.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LookPhotoModel.h"

@implementation LookDao

+ (void)getLookPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail {
    
    AVQuery *query = [AVQuery queryWithClassName:@"LookViewPhoto"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                LookPhotoModel *model = [[LookPhotoModel alloc] initWithObject:object];
                [arrayM addObject:model];
                NSLog(@"%@",model);
            }
            sucess(arrayM);
        }
    }];
}
@end
