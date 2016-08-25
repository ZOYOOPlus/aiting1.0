//
//  HMImageCell.m
//  02-自定义UICollectionView布局
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMImageCell.h"

@interface HMImageCell()

@end

@implementation HMImageCell

- (void)setImage:(NSString *)image {
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

- (void)awakeFromNib {
//    self.imageView.layer.borderWidth = 5;
//    [self.imageView setValue:@5 forKeyPath:@"layer.borderWidth"];
//    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 30;
    self.imageView.layer.masksToBounds = YES;
  //  self.imageView.layout.minimumInteritemSpacing = 0
//    self.imageView.layer.borderColor = [[UIColor orangeColor] CGColor];
//    self.imageView.layer.borderWidth = 2.0f;
}

@end
