//
//  ShopPhotoModel.h
//  baobei
//
//  Created by 张源海 on 16/7/10.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface ShopPhotoModel : NSObject

@property (nonatomic, strong) AVObject *avObject;
@property (nonatomic, strong) NSString *objectIdl;
@property  (nonatomic, strong) NSString *Photos;
@property  (nonatomic,strong) NSString  *GP_Price;
@property  (nonatomic,strong) NSString  *GP_Sell;
@property (nonatomic,strong) NSString  *GP_Name;
@property (nonatomic,strong) NSString  *GP_Address;

- (instancetype)initWithObject:(AVObject *)object;

@end
