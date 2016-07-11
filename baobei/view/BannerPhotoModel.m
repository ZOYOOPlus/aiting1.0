//
//  BannerPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/7/11.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BannerPhotoModel.h"

@implementation BannerPhotoModel
- (instancetype)initWithObject:(AVObject *)object {
    if (self = [super init]) {
        self.avObject = object;
        self.objectIdl = object.objectId;
        AVFile *file = [object objectForKey:@"BannerPhoto"];
        self.Banner_URL = file.url?file.url:@"";
        self.BannerPhoto = file.url?file.url:@"";
    }
    return self;
}

@end
