//
//  ShopCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/17.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShopCell.h"
#import "ShopPhotoModel.h"
@interface ShopCell ()
@property (nonatomic, strong) UIImageView *goodsImageView;

@end

@implementation ShopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setShopPhotoMode:(ShopPhotoModel *)shopPhotoMode {
    _shopPhotoMode = shopPhotoMode;
    self.price.text = shopPhotoMode.GP_Price;
    self.sales.text = shopPhotoMode.GP_Sell;
    self.address.text = shopPhotoMode.GP_Address;
    self.goodsName.text = shopPhotoMode.GP_Name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shopPhotoMode.Photos]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
}


- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.price];
  //  [self.contentView addSubview:self.address];
    [self.contentView addSubview:self.sales];
    [self.contentView addSubview:self.goodsName];
}

- (UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _goodsImageView;
}

- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _price.font = [UIFont systemFontOfSize:15];
    }
    return _price;
}

- (UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] initWithFrame:CGRectZero];
        _address.textColor = [UIColor colorWithRed:0.65 green:0.66 blue:0.66 alpha:1];
        _address.font = [UIFont systemFontOfSize:15];
    }
    return _address;
}

- (UILabel *)sales{
    if (!_sales) {
        _sales = [[UILabel alloc] initWithFrame:CGRectZero];
        _sales.textColor = [UIColor colorWithRed:0.98 green:0.55 blue:0.39 alpha:1];
        _sales.font = [UIFont systemFontOfSize:15];
    }
    return _sales;
}

- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _goodsName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    /**
     *  UI 测试
     */
//    if (self.goodsImageView.frame.size.height>150) {
//         self.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi2.jpg"];
//    }else{
//        self.goodsImageView.image = [UIImage imageNamed:@"update2/xianshi.jpg"];
//    }
   
//    self.price.text = @"99元";
  //  self.goodsName.text = @"商品名";
//   self.address.text = @"北京";
//    self.sales.text = @"已售1040份";
  
   

    [self.price sizeToFit];
   // [self.address sizeToFit];
    [self.sales sizeToFit];
    [self.goodsName sizeToFit];
   
//    _goodsImageView.layer.borderWidth = 5;
//    _goodsImageView.layer.borderColor = [[UIColor orangeColor] CGColor];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).offset(-5);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(kImageProportion);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(55);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(20);
    }];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(20);
    }];
    
//    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(5);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-4);
//    }];
    
        [self.sales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(20);
    }];
}



-(void)prepareForReuse{
    
}

@end
