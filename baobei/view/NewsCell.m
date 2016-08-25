//
//  NewsCell.m
//  baobei
//
//  Created by 张源海 on 16/7/13.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 220, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];

    }
    return self;
}


@end
