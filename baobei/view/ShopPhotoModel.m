//
//  ShopPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/7/10.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShopPhotoModel.h"

@implementation ShopPhotoModel
- (instancetype)initWithObject:(AVObject *)object {
    if (self = [super init]) {
        self.avObject = object;
        self.objectIdl = object.objectId;
        AVFile *file = [object objectForKey:@"Photos"];
        self.Photos = file.url?file.url:@"";
    }
    return self;
}
@end
