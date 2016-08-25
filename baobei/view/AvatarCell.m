//
//  AvatarCell.m
//  jyt
//
//  Created by 贺少虎 on 16/4/27.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "AvatarCell.h"
#import "HCommon.h"

@implementation AvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.layer.borderColor = RGB(255, 217, 69).CGColor;
        self.imageView.layer.borderWidth = 2.0f;
        self.imageView.layer.cornerRadius = 5.0f;
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width-80);

}



@end
