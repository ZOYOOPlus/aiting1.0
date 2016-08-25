//
//  LookPhotoModel.h
//  baobei
//
//  Created by 张源海 on 16/8/13.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface LookPhotoModel : NSObject
@property (nonatomic,strong)NSString *LookPhoto;
@property (nonatomic,strong)NSString *Look_URL;
@property (nonatomic,strong)NSString *Look_title;

- (instancetype)initWithObject:(AVObject *)object;

@end
