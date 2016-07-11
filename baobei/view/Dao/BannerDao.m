//
//  BannerDao.m
//  baobei
//
//  Created by 张源海 on 16/7/11.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BannerDao.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BannerPhotoModel.h"

@implementation BannerDao

+(void)getBannerPhotoWithUserId:(NSString *)useid sucess:(void (^)(NSArray *))sucess fail:(void (^)())fail{
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsPhoto"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                BannerPhotoModel *model = [[BannerPhotoModel alloc] initWithObject:object];
                [arrayM addObject:model];
            }
            sucess(arrayM);
        }
    }];

}
@end
