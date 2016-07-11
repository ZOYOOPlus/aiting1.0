//
//  ListenCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ListenCell.h"

@implementation ListenCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        self.isPlay = NO;
        [self.contentView addSubview:self.imageView];
        
        [self.contentView addSubview:self.likeImageView];
        [self.contentView addSubview:self.name];
        NAKPlaybackIndicatorView *indicator = [[NAKPlaybackIndicatorView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:indicator];
        [indicator sizeToFit];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 10;
    }
    return _imageView;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_like"] highlightedImage:[UIImage imageNamed:@"home_like_high"]];
    }
    return _likeImageView;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = [UIColor grayColor];
        
    }
    return _name;
}

- (void)setData:(ListenData *)data{
    self.imageView.image = [UIImage imageNamed:data.imageName];
    self.name.text = data.title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.6);
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.name sizeToFit];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.width.equalTo(self.contentView.mas_width);
//        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.3);
    }];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}


@end
