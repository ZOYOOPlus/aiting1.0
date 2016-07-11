//
//  LFYSessionManager.h
//  网易新闻
//
//  Created by lfy on 15/11/9.
//  Copyright © 2015年 lfy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef void (^SuccessData)(id data);
typedef void (^failureData)(NSError *error);

@interface LFYSessionManager : AFHTTPSessionManager

+ (void)dataWithUrlString:(NSString *)urlString andSuccessBlock:(SuccessData)getData failureBlock:(failureData)failureData;

+ (void)dataWithUrlString:(NSString *)urlString andParameter:(NSDictionary *)dic SuccessBlock:(SuccessData)getData failureBlock:(failureData)failureData;

+ (void)dataWithUrlString:(NSString *)urlString andParameter:(NSDictionary *)dic andImage:(UIImage *)image SuccessBlock:(SuccessData)getData failureBlock:(failureData)failureData;

@end
