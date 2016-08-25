//
//  AVUserd.m
//  baobei
//
//  Created by 张源海 on 16/8/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "AVUserd.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation AVUserd
//@property (nonatomic,strong)NSString *userphoto;
//@property (nonatomic,strong)NSString *birthday;
//@property  (nonatomic,strong)NSString *chirdenname;
//@property (nonatomic,strong)NSString  *sex;
//@property (nonatomic,strong)NSString *adress;
- (instancetype)initWithObject:(AVObject *)object {
    if (self = [super init]) {
      
        AVFile *file = [object objectForKey:@"_user"];
        self.userphoto = file.url?file.url:@"";
        NSString *birthday = [object  objectForKey:@"birthday"];
        self.birthday =birthday;
        NSString  *chirdenname   = [object  objectForKey:@"chirdenname"];
        self.chirdenname = chirdenname;
        NSString *sex = [object  objectForKey:@"sex"];
        self.sex = sex;
        NSString *adress = [object  objectForKey:@"adress"];
        self.adress = adress;
        NSString *userage = [object objectForKey:@"userage"];
        self.userage = userage;
    }
    return self;
}




@end
