//
//  ShowPhotoModel.h
//  baobei
//
//  Created by 张源海 on 16/8/6.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface ShowPhotoModel : NSObject

@property (nonatomic, strong) AVObject *avObject;
@property (nonatomic, strong) NSString *objectIdl;

@property  (nonatomic, strong) NSString *SW_photo;
@property  (nonatomic,strong) NSString  *S_name;
@property  (nonatomic,strong) NSString  *S_zan;

- (instancetype)initWithObject:(AVObject *)object;

@end
