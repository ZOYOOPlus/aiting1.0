//
//  LKLotteryView.h
//  lottery
//
//  Created by upin on 13-3-6.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKLotteryView : UIView
-(id)initWithDialPanel:(UIImage*)panel pointer:(UIImage*)pointer;
-(void)setDialPanel:(UIImage*)panel pointer:(UIImage*)pointer;

@property(retain,nonatomic)UIImageView* dialView;
@property(retain,nonatomic)UIImageView* pointerView;


-(void)start;
-(void)startDuration:(float)duration endAngle:(float)angle;
@property(copy,nonatomic) void(^endEvent)(float angle);
@end
