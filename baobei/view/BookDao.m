//
//  BookDao.m
//  baobei
//
//  Created by 张源海 on 16/8/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BookDao.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BookPhotoModel.h"

@implementation BookDao
// 请求书的名字
+ (void)getBookPhotoWithUserid:(NSString *)userid sucess:(void(^)(NSArray *list))sucess fail:(void(^)())fail{
    AVQuery *query = [AVQuery queryWithClassName:@"Books"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                BookPhotoModel *model = [[BookPhotoModel alloc] initWithObject:object];
                [arrayM addObject:model];
                NSLog(@"%@",model);
            }
            sucess(arrayM);
        }
    }];
}
// 萤火奇兵书的内容
+(void)getYinghuoPhotoWithUserid:(NSString *)userid sucess:(void (^)(NSArray *))sucess fail:(void (^)())fail
{
    AVQuery *query = [AVQuery queryWithClassName:@"YinghuoHero"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            fail(error);
        }else {
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:42];
            for (AVObject *object in objects) {
                BookPhotoModel *model = [[BookPhotoModel alloc] initWithObject:object];
                [arrayM addObject:model];
                NSLog(@"%@",model);
            }
            sucess(arrayM);
        }
    }];
    
}

// 天外来客书的内容
+(void)getTianwaiPhotoWithUserid:(NSString *)userid sucess:(void (^)(NSArray *))sucess fail:(void (^)())fail
{
    
}
// 保卫家园书的内容
+(void)getBaoweiPhotoWithUserid:(NSString *)userid sucess:(void (^)(NSArray *))sucess fail:(void (^)())fail
{
    
}
// 奇妙的海底世界书的内容
+(void)getQimiaoPhotoWithUserid:(NSString *)userid sucess:(void (^)(NSArray *))sucess fail:(void (^)())fail
{
    
}
@end
