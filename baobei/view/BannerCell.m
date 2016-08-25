//
//  BannerCell.m
//  baobei
//
//  Created by 张源海 on 16/7/11.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BannerCell.h"
#import "BannerPhotoModel.h"
@interface  BannerCell()
@property (nonatomic, strong) UIImageView *BannerImageView;

@end
@implementation BannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    
    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:self.BannerImageView];

}


- (void)setBannerPhotoMode:(BannerPhotoModel *)bannerPhotoMode
{
    _bannerPhotoMode = bannerPhotoMode;

        [self.BannerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",bannerPhotoMode.BannerPhoto]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
    
}

-(void)prepareForReuse{
    
}
@end
