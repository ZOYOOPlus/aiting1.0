//
//  PaintPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/7/19.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "PaintPhotoModel.h"

@implementation PaintPhotoModel
- (instancetype)initWithObject:(AVObject *)object {
    if (self = [super init]) {
        self.avObject = object;
        self.objectIdl = object.objectId;
        AVFile *file = [object objectForKey:@"Park_Photo"];
        self.Photos = file.url?file.url:@"";
    }
    return self;
}
@end
