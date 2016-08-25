//
//  UserModel.m
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (instancetype)initWithObject:(AVObject *)object {
    if (self = [super init]) {
      
        AVFile *file = [object objectForKey:@"UserPhoto"];
        self.UserPhoto = _UserPhoto;

    }
    return self;
}
@end
