//
//  ShopDao.m
//  baobei
//
//  Created by 张源海 on 16/7/10.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShopDao.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ShopPhotoModel.h"
@implementation ShopDao
+ (void)getShopPhotoWithUserId:(NSString *)useid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail {
   
    AVQuery *query = [AVQuery queryWithClassName:@"GoodsPhoto"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                ShopPhotoModel *model = [[ShopPhotoModel alloc] initWithObject:object];
                [arrayM addObject:model];
            }
            sucess(arrayM);
        }
    }];
}
@end
