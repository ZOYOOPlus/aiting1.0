//
//  UserModel.h
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface UserModel : NSObject

@property (nonatomic, strong)NSString *UserPhoto;
//@property  (nonatomic,strong)NSString  *username;


- (instancetype)initWithObject:(AVObject *)object;

@end
