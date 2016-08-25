//
//  FloodFillImageView.m
//  ImageFloodFilleDemo
//
//  Created by chintan on 11/07/13.
//  Copyright (c) 2013 ZWT. All rights reserved.
//
//
#import "FloodFillImageView.h"

@implementation FloodFillImageView

@synthesize tolorance,newcolor;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取触摸点
    CGPoint tpoint = [[[event allTouches] anyObject] locationInView:self];
    //Convert Touch Point to pixel of Image
    //转换接触点到图像的像素
    //This code will be according to your need
    // 手势的偏移量 1.27   1.07
    tpoint.x = tpoint.x * 1.27 ;
    tpoint.y = tpoint.y * 1.07;
    
    //调用函数洪水填充和获得与填充颜色新形象
    UIImage *image1 = [self.image floodFillFromPoint:tpoint withColor:newcolor andTolerance:tolorance];
    
    dispatch_async(dispatch_get_main_queue(), ^(void)
    {
        [self setImage:image1];
    });
}
@end