//
//  VideoView.m
//  baobei
//
//  Created by 贺少虎 on 16/5/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "VideoView.h"

@interface  VideoView()

@end

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"K_demo.jpg"]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [self addSubview:image];
        image.frame = self.bounds;
    }
    return self;
}

@end
