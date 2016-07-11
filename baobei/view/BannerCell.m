//
//  BannerCell.m
//  baobei
//
//  Created by 张源海 on 16/7/11.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BannerCell.h"

@implementation BannerCell
//- (void)setShopPhotoMode:(ShopPhotoModel *)shopPhotoMode {
//    _shopPhotoMode = shopPhotoMode;
//    //    [self.goodsImageView sd_setImageWithURL];
//    //    [self.goodsImageView sd_setImageWithURL:placeholderImage:[UIImage imageNamed:@"head"] options:nil]];
//    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shopPhotoMode.Photos]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
//}
- (void)setBannerPhotoMode:(BannerPhotoModel *)bannerPhotoMode
{
    _bannerPhotoMode = bannerPhotoMode;
    
        
}
@end
