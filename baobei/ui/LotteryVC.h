//
//  LotteryVC.h
//  baobei
//
//  Created by 张源海 on 16/8/4.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BaseVC.h"

#import "LKLotteryView.h"
@interface LotteryVC : BaseVC
{
    NSTimer *_scrollTimer;
}

@property (nonatomic) CGFloat pointsPerSecond;

- (void)startScrolling;

- (void)stopScrolling;



@end
