//
//  HWordListCell.m
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HWordListCell.h"

@implementation HWordListCell

+ (CGFloat)getCellWidth{
    return 100;
}

//+ (UILabel *)handleLabel:(UILabel *)label{
//    label.font = [UIFont fontWithName:APP_FONT size:20];
//    
//    return label;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.title];
    }
    return self;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.font = [UIFont fontWithName:APP_FONT size:16];
        _title.textColor = [UIColor colorWithHexString:@"#080604"];
    }
    return _title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.title sizeToFit];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}



@end
