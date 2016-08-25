//
//  BookPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/8/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BookPhotoModel.h"

@implementation BookPhotoModel
- (instancetype)initWithObject:(AVObject *)object {
    
    if (self = [super init]) {
        
        AVFile *file = [object objectForKey:@"bookphoto"];
        self.BookPhoto = file.url?file.url:@"";
        
        AVFile *yinghuofile = [object objectForKey:@"yh_photo"];
        self.yinghuoPhoto = yinghuofile.url?yinghuofile.url:@"";
        
    }
    return self;
}
@end
