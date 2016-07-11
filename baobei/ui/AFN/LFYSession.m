//
//  LFYSession.m
//  网易新闻
//
//  Created by lfy on 15/11/9.
//  Copyright © 2015年 lfy. All rights reserved.
//

#import "LFYSession.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
//#import "SystemServices.h"
//#import "LFYBusinessModel.h"

@implementation LFYSession

//#define SystemSharedServices [SystemServices sharedServices]

//http://toutiao.com/api/article/recent/?source=0&count=20&category=童书绘本&offset=0

//api/article/recent/?source=0&count=20&category=童书绘本&offset=0

+ (instancetype)sharedSession{
    static LFYSession *session;
    
    NSURL *url = [NSURL URLWithString:@"http://toutiao.com"];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         session = [[LFYSession alloc]initWithBaseURL:url];
        LFYSession *newSession = (LFYSession *)session;

        newSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/javascript",@"text/plain", nil];
        
        newSession.requestSerializer.timeoutInterval = 10;
        
//        NSString *version = [NSString stringWithFormat:@"%@ %@",[SystemSharedServices systemName],[SystemSharedServices systemsVersion]];
//        
//        NSString *deviceType = [SystemSharedServices systemDeviceTypeFormatted];
//        NSString *screenSize = [NSString stringWithFormat:@"%tu * %tu",[SystemSharedServices screenHeight],[SystemSharedServices screenWidth]];
//        NSString *identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        
//        [newSession.requestSerializer setValue:identifier forHTTPHeaderField:@"X-DEVICE-NUM"];
//        
//        [newSession.requestSerializer setValue:@"IOS-1.0.0" forHTTPHeaderField:@"X-VERSION"];
//        
//        [newSession.requestSerializer setValue:deviceType forHTTPHeaderField:@"X-TYPE"];
//        
//        [newSession.requestSerializer setValue:version forHTTPHeaderField:@"X-SYSTEM"];
//        
//        [newSession.requestSerializer setValue:screenSize forHTTPHeaderField:@"X-SCREEN"];
//        
//        [newSession.requestSerializer setValue:@"1100" forHTTPHeaderField:@"X-MARKET"];
//        
//        LFYUser *myUser = [LFYBusinessModel sharedLFYBusinessModel].myUser;
//        
//        [newSession.requestSerializer setValue:[NSString stringWithFormat:@"%@",myUser.uid] forHTTPHeaderField:@"X-UID"];
//        NSLog(@"%@",[LFYBusinessModel sharedLFYBusinessModel].pushId);
//        [newSession.requestSerializer setValue:[NSString stringWithFormat:@"%@",[LFYBusinessModel sharedLFYBusinessModel].pushId] forHTTPHeaderField:@"X-PUSHID"];
        
    });

    return session;
    
    
}

@end
