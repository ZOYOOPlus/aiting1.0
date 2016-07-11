//
//  HUIButton.m
//  baobei
//
//  Created by 贺少虎 on 16/5/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HUIButton.h"

@implementation HUIButton

- initWithImage:(NSString *)imageName title:(NSString *)str{
    self = [super initWithFrame:CGRectMake(0, 0, kHButtonWidth, kHButtonHeight)];
    if (self) {
        UIImage *image = [UIImage imageNamed:imageName];
        
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        [self setTitle:str forState:UIControlStateNormal];
        [self setTitle:str forState:UIControlStateHighlighted];
        self.backgroundColor = [UIColor greenColor];
        self.imageEdgeInsets = UIEdgeInsetsMake(10, 10, kHButtonHeight * 0.4, -20);
        self.titleEdgeInsets = UIEdgeInsetsMake(kHButtonHeight * 0.6,-image.size.width/2, 0, 25);
    }
    return self;
}

@end
