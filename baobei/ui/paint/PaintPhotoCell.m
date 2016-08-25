//
//  PaintPhotoCell.m
//  baobei
//
//  Created by 张源海 on 16/7/19.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "PaintPhotoCell.h"
#import "ShopPhotoModel.h"
#import "HCommon.h"
@interface PaintPhotoCell()
@property (nonatomic, strong) UIImageView *PhotosImageView;
@end
@implementation PaintPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];   
    }
    
    return self;
}

- (void)setPaintPhotoMode:(PaintPhotoModel *)PaintPhotoMode {
    _PaintPhotoMode = PaintPhotoMode;
    
//      [self.PhotosImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",PaintPhotoModel.photo]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
//  
}
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:self.PhotosImageView];
}

- (UIImageView *)goodsImageView{
    if (!_PhotosImageView) {
        _PhotosImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _PhotosImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _PhotosImageView;
}

-(void)prepareForReuse{
    
}
@end
