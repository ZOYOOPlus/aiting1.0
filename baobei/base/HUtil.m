//
//  HUtil.m
//  jyt
//
//  Created by 贺少虎 on 16/4/14.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HUtil.h"

@implementation HUtil

+ (UIImage*)createImageWithColor:(UIColor*)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,[color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}


@end
