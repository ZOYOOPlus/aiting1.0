//
//  ListenModel.h
//  baobei
//
//  Created by 张源海 on 16/8/19.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListenModel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *musicURL;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *reward;
@property (nonatomic,strong) UIButton *leftNextBtn;
@property (nonatomic,strong) UIButton *rightNextBtn;
@property (nonatomic,strong) UILabel *playTime;
@property (nonatomic,strong) UILabel *playTimes;


@end
