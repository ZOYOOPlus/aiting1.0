//
//  HShareCell.m
//  jyt
//
//  Created by 贺少虎 on 16/5/23.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HShareCell.h"
#import "HCommon.h"

@implementation HShareCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.title];

    }
    return self;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 10)];
        [_title setTextAlignment:NSTextAlignmentCenter];
        _title.font = [UIFont systemFontOfSize:12];
        _title.textColor = [UIColor darkGrayColor];
        _title.numberOfLines = 0;
    }
    return _title;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImage;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.title.text = @"朋友圈";
    self.iconImage.image = [UIImage imageNamed:@"Action_Moments.png"];

    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_width);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    [self.title sizeToFit];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage.mas_bottom).offset(5);
        make.width.equalTo(self.contentView.mas_width);
    }];
}

@end
