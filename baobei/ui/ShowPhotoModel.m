//
//  ShowPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/8/6.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowPhotoModel.h"

@implementation ShowPhotoModel

- (instancetype)initWithObject:(AVObject *)object{

    if (self = [super init]) {
        self.avObject = object;
        self.objectIdl = object.objectId;
        
        AVFile *file = [object objectForKey:@"SW_photo"];
        
        self.SW_photo = file.url?file.url:@"";
        
        NSString *sw_name = [object objectForKey:@"SW_name"];
        
        self.SW_name = sw_name;
        
        NSString *sw_zan = [object objectForKey:@"SW_zan"];
        
        self.SW_zan  = sw_zan;
    }

    return self;

}
@end
