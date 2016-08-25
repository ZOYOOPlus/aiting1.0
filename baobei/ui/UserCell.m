//
//  UserCell.m
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "UserCell.h"
#import "UserModel.h"
@interface UserCell()
@property (nonatomic, strong) UIImageView *UserImageView;
@end
@implementation UserCell

-(void)setUserModel:(UserModel *)userModel{

    userModel = _userModel;
     [self.UserImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userModel.UserPhoto]] placeholderImage:[UIImage imageNamed:@"head.jpg"]];
}


- (UIImageView *)UserImageView{
    if (!_UserImageView) {
        _UserImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _UserImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _UserImageView;
}

- (void)awakeFromNib {
    // Initialization code
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
