//
//  ShowCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowCell.h"

@interface ShowCell()

@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIImageView *likeImageView;

@end

@implementation ShowCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.likeImageView];
        [self.contentView addSubview:self.userName];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_like_high"]];
    }
    return _likeImageView;
}

- (UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _userName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.userName.text = @"壮壮";
    [self.userName sizeToFit];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).offset(-10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.height.equalTo(self.contentView.mas_width).offset(-10);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);

    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}



@end
