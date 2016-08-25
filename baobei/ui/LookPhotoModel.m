//
//  LookPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/8/13.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LookPhotoModel.h"

@implementation LookPhotoModel

- (instancetype)initWithObject:(AVObject *)object {
    
    if (self = [super init]) {
     
        AVFile *file = [object objectForKey:@"LookPhoto"];
        self.LookPhoto = file.url?file.url:@"";
        
        NSString *lookurl = [object  objectForKey:@"Look_title"];
        self.Look_title =lookurl;
      
    }
    return self;
}

@end
