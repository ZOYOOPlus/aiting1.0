//
//  BannerPhotoModel.h
//  baobei
//
//  Created by 张源海 on 16/7/11.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface BannerPhotoModel : NSObject
@property (nonatomic, strong) AVObject *avObject;
@property (nonatomic, strong) NSString *objectIdl;
@property (nonatomic,strong)NSString *BannerPhoto;
@property (nonatomic,strong)NSString  *Banner_URL;
- (instancetype)initWithObject:(AVObject *)object;

@end
