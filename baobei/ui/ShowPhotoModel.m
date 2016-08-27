//
//  ShowPhotoModel.m
//  baobei
//
//  Created by 张源海 on 16/8/6.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowPhotoModel.h"

@implementation ShowPhotoModel

- (instancetype)initWithObject:(AVObject *)object{

    if (self = [super init]) {
        self.avObject = object;
        self.objectIdl = object.objectId;
        
        AVFile *file = [object objectForKey:@"SW_photo"];
        self.SW_photo = file.url?file.url:@"";
        
        NSString *sw_name = [object objectForKey:@"S_name"];
        self.S_name = sw_name;
    
        
        NSString *sw_zan = [object objectForKey:@"szan"];
        self.S_zan  = sw_zan;
  
    }

    return self;

}

//- (instancetype)initWithObject:(AVObject *)object {
//    if (self = [super init]) {
//        self.avObject = object;
//        self.objectIdl = object.objectId;
//        AVFile *file = [object objectForKey:@"Photos"];
//        self.Photos = file.url?file.url:@"";
//        NSString *price = [object  objectForKey:@"GP_Price"];
//        self.GP_Price =price;
//        NSString  *sell   = [object  objectForKey:@"GP_Sell"];
//        self.GP_Sell = sell;
//        NSString *GPname = [object  objectForKey:@"GP_Name"];
//        self.GP_Name = GPname;
//        NSString *address = [object  objectForKey:@"GP_Address"];
//        self.GP_Address = address;
//    }
//    return self;
//}

@end
