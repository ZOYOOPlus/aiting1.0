//
//  TestCollectionViewCell.m
//  baobei
//
//  Created by 贺少虎 on 16/6/18.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell ()


@end

@implementation TestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.testImage];
    }
    return self;
}

- (UIImageView *)testImage{
    if (!_testImage) {
        _testImage = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _testImage;
}


@end
