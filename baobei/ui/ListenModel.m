//
//  ListenModel.m
//  baobei
//
//  Created by 张源海 on 16/8/19.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ListenModel.h"

@implementation ListenModel

- (instancetype)iniTWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
