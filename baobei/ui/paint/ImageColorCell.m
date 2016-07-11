//
//  ImageColorCell.m
//  baobei
//
//  Created by 张源海 on 16/7/4.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ImageColorCell.h"

@interface ImageColorCell()
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton  *buttons;

@end
@implementation ImageColorCell
//- (void)setImage:(NSString *)image {
//    _image = [image copy];
//    self.imageView.image = [UIImage imageNamed:image];
//}
-(void)setButtons:(UIButton *)buttons{
    _buttons = [buttons copy];
}
//- (void)awakeFromNib {
//
//    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.imageView.layer.cornerRadius = 10;
//    self.imageView.layer.masksToBounds = YES;
//    
//}
- (void)awakeFromNib {
    
    self.buttons.layer.borderColor = [UIColor whiteColor].CGColor;
 
}

@end
