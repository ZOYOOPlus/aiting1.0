//
//  HImageListCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HImageListCell.h"

@implementation HImageListCell

- (void)setImgStr:(NSString *)imgStr {
    _imgStr = imgStr;
    NSString *file = [NSString stringWithFormat:@"%@.acc", imgStr];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    _playFile = [path stringByAppendingPathComponent:file];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
    }
    return _imageView;
}

// set 方法
-(void)setBookPhotoModel:(BookPhotoModel *)yinghuoPhotoModel
{
    _yinghuoPhotoModel = yinghuoPhotoModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",yinghuoPhotoModel.yinghuoPhoto]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
    
}

@end
