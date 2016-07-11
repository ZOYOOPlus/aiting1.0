//
//  LFYSession.h
//  网易新闻
//
//  Created by lfy on 15/11/9.
//  Copyright © 2015年 lfy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface LFYSession : AFHTTPSessionManager

+ (instancetype)sharedSession;


@end
