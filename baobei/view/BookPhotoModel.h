//
//  BookPhotoModel.h
//  baobei
//
//  Created by 张源海 on 16/8/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface BookPhotoModel : NSObject
@property (nonatomic,strong)NSString *BookPhoto;
@property (nonatomic,strong)NSString *yinghuoPhoto;

- (instancetype)initWithObject:(AVObject *)object;
@end
