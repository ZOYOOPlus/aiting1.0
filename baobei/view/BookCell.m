//
//  BookCell.m
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BookCell.h"
@interface BookCell()

@end
@implementation BookCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.exchangeBtn];
        [self.contentView addSubview:self.downBtn];
         //   [self.contentView addSubview:self.exchag];
    }
    return self;
}
#pragma mark  set模型 
-(void)setBookPhotoModel:(BookPhotoModel *)bookPhotoModel
{
        _bookPhotoModel = bookPhotoModel;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",bookPhotoModel.BookPhoto]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];

}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}
- (UIButton *)exchangeBtn{
    
    if (!_exchangeBtn) {
        _exchangeBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    }
    return _exchangeBtn;
    
}
- (UILabel *)exchag{
    
    if (!_exchag) {
        _exchag = [[UIButton alloc]initWithFrame:CGRectZero];
    }
    return _exchag;
    
}
- (UIButton *)downBtn{

    if (!_downBtn) {
        _downBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    }
    return _downBtn;

}
- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.userName.textColor = [UIColor  whiteColor];
//    [self.userName sizeToFit];
//    _userName.backgroundColor = [UIColor orangeColor];
//    _userName.textAlignment = UITextAlignmentCenter;
//       [self.exchangeBtn setImage:[UIImage imageNamed:@"icons_@_03"] forState:UIControlStateNormal];
          [self.exchangeBtn setTitle:@"10币兑换" forState:UIControlStateNormal];
    [self.exchangeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //_exchag.text = @"兑换";
        [self.downBtn setImage:[UIImage imageNamed:@"icons_@_07"] forState:UIControlStateNormal];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        // 设置加载图片的宽高比  
         make.size.mas_equalTo (CGSizeMake(fDeviceWidth/2-15, (fDeviceWidth/2-15)));
    }];

    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
        make.size.mas_equalTo (CGSizeMake(20, 20));
    }];
    
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
        make.size.mas_equalTo (CGSizeMake(80, 25));
    }];
    
}
@end