//
//  ShowCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowCell.h"
#import "ShowPhotoModel.h"
@interface ShowCell()
@property (nonatomic, strong) UIImageView *likeImageView;

@end

@implementation ShowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
//        [self.contentView addSubview:self.imageView];
//        [self.contentView addSubview:self.likeImageView];
//        [self.contentView addSubview:self.userName];
//        [self.contentView addSubview:self.zan];
//    }
//    return self;
//}

-(void)setupUI{
            self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
            [self.contentView addSubview:self.imageView];
            [self.contentView addSubview:self.likeImageView];
            [self.contentView addSubview:self.userName];
            [self.contentView addSubview:self.zan];
}
- (void)setShowPhotoMode:(ShowPhotoModel *)showPhotoMode{
    
    _showPhotoMode = showPhotoMode;
    
    self.userName.text = showPhotoMode.S_name;
        self.zan.text               = showPhotoMode.S_zan;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",showPhotoMode.SW_photo]] placeholderImage:[UIImage imageNamed:@"01"]];

}

- (UILabel *)zan{

    if (!_zan) {
        _zan = [[UILabel alloc]initWithFrame:CGRectZero];
        _zan.font = [UIFont systemFontOfSize:15];
    }
    return _zan;

}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_like"] highlightedImage:[UIImage imageNamed:@"home_like_high"]];
    }
    return _likeImageView;
}

- (UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc] initWithFrame:CGRectZero];
               _userName.font = [UIFont systemFontOfSize:15];
    }
    return _userName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).offset(-10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.height.equalTo(self.contentView.mas_width).offset(-10);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.contentView.mas_right).offset(-45);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];
    
    [self.zan mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self.contentView.mas_right).offset(-1);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}

-(void)prepareForReuse{
    
}

@end
