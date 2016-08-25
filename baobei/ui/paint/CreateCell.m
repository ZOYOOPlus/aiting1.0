//
//  CreateCell.m
//  baobei
//
//  Created by 张源海 on 16/7/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "CreateCell.h"
@interface CreateCell()
@end


@implementation CreateCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:self.imageView];
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

- (UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _userName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    

    self.userName.textColor = [UIColor  whiteColor];
    [self.userName sizeToFit];
    _userName.backgroundColor = [UIColor orangeColor];
    
      _userName.textAlignment = UITextAlignmentCenter;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).offset(-20);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.height.equalTo(self.contentView.mas_width).offset(-30);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
        make.size.mas_equalTo (CGSizeMake(fDeviceWidth/2-25-10, 30));
    }];

}




@end
