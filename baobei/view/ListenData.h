//
//  ListenData.h
//  baobei
//
//  Created by 贺少虎 on 16/5/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    MyEnumValueA,
    MyEnumValueB,
//    MyEnumValueC,

} MyEnum;



//Data 层 写  数据 Model 
@interface ListenData : NSObject

@property (nonatomic,assign) MyEnum status;

@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *musicURL;
@property (nonatomic,strong) UIImageView *imageView;
//@property (nonatomic,strong) UIButton *leftNextBtn;
//@property (nonatomic,strong) UIButton *rightNextBtn;



@property (nonatomic,strong) NSString *playTime;
@property (nonatomic,strong) NSString *playTimes;
@property (nonatomic,strong) NSString *reward;
//@property (nonatomic,strong) UIButton  *play;
//@property (nonatomic,strong) UIImageView *musicView;



- (NSMutableArray *)getsMusicData;
- (NSMutableArray  *)getsListenList;

+ (ListenData *)shareInstance;
@end
