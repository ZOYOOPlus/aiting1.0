//
//  LFYSessionManager.m
//  网易新闻
//
//  Created by lfy on 15/11/9.
//  Copyright © 2015年 lfy. All rights reserved.
//

#import "LFYSessionManager.h"
#import "LFYSession.h"
//#import "SVProgressHUD.h"

@implementation LFYSessionManager

//+(void)initialize{
//    
//    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
//}

+ (void)dataWithUrlString:(NSString *)urlString andSuccessBlock:(SuccessData)getData failureBlock:(failureData)failureData{

    
    [[LFYSession sharedSession] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (getData) {
            getData(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@",error);
        if (failureData) {
            
            failureData(error);
        }
        
        NSString *str = nil;
        
        if (error.code == -1001) {
            str = [NSString stringWithFormat:@"%@",@"请求超时,请重试"];
        }else{
            str = [NSString stringWithFormat:@"%@",@"请检查网络连接"];
        }
        
//        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",str]];
        


    }];
     
}

+ (void)dataWithUrlString:(NSString *)urlString andParameter:(NSDictionary *)dic SuccessBlock:(SuccessData)getData failureBlock:(failureData)failureData{

    
    
    [[LFYSession sharedSession] POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (getData) {
            getData(responseObject);
            
        }
//        NSLog(@"%@",[LFYSession sharedSession].requestSerializer.HTTPRequestHeaders);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@",error);
        if (failureData) {
            
            failureData(error);
        }
        
        NSString *str = nil;
        
        if (error.code == -1001) {
            str = [NSString stringWithFormat:@"%@",@"请求超时,请重试"];
        }else{
            str = [NSString stringWithFormat:@"%@",@"请检查网络连接"];
            
        }

//        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",str]];
        
        
    }];
    
}

+ (void)dataWithUrlString:(NSString *)urlString andParameter:(NSDictionary *)dic andImage:(UIImage *)image SuccessBlock:(SuccessData)getData failureBlock:(failureData)failureData{
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    
    
    [[LFYSession sharedSession] POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@".jpeg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (getData) {
            getData(responseObject);
            
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error:%@",error);
        if (failureData) {
            
            failureData(error);
        }
        
        NSString *str = nil;
        
        if (error.code == -1001) {
            str = [NSString stringWithFormat:@"%@",@"请求超时，请重试"];
        }else{
            str = [NSString stringWithFormat:@"%@",@"请检查网络连接"];
        }
        
//        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",str]];

        
    }];

        


}



@end
