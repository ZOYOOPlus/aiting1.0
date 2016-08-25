//
//  ShowDao.m
//  baobei
//
//  Created by 张源海 on 16/8/6.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowDao.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ShowPhotoModel.h"
@implementation ShowDao
+ (void)getShowPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail {
    
    AVQuery *query = [AVQuery queryWithClassName:@"ShowWorks"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                ShowPhotoModel *model = [[ShowPhotoModel alloc] initWithObject:object];
                [arrayM addObject:model];
                NSLog(@"%@",model);
            }
            sucess(arrayM);
        }
    }];
}
@end
