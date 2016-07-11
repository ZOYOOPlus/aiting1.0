//
//  ActivityModel.m
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (void)setPublisDateWithTimestamp:(NSTimeInterval)timestamp{
    self.publisDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
}




- (instancetype)iniTWithDict:(NSDictionary *)dict{
    
//    ActivityModel *model= [[ActivityModel alloc]init];
    
//    model.title = Dict[@"title"];
//    if (self = [[super alloc] init]) {
    
//    }
//    if (self = [) {
//        <#statements#>
//    }
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
