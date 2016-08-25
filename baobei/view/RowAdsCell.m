//
//  RowAdsCell.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "RowAdsCell.h"
@interface RowAdsCell()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation RowAdsCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.imageView];

    }
    return self;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont fontWithName:APP_FONT size:18];
    }
    
    return  _title;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}


- (void)setAds:(AdsModel *)ads{
    if (_ads == ads) {
        return;
    }
    _ads = ads;
    self.title.text = _ads.title;
    self.imageView.image = [UIImage imageNamed:_ads.imageName];
    if (_ads.imageHight) {
        self.imageView.highlightedImage = [UIImage imageNamed:_ads.imageHight];
    }
       self.layer.masksToBounds = YES; //没这句话它圆不起来
       self.layer.cornerRadius = 8.0; //设置图片圆角的尺度
    self.backgroundColor = [UIColor colorWithHexString:_ads.color];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.title sizeToFit];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-15);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(25);
    }];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.title.textColor = [UIColor blackColor];
    }else{
    }
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.title.textColor = [UIColor blackColor];
    }else{
        self.title.textColor = [UIColor whiteColor];
    }
}

@end
