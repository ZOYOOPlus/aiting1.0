//
//  ListenData.m
//  baobei
//
//  Created by 贺少虎 on 16/5/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ListenData.h"
#import "ListenCell.h"
#import "ListenModel.h"


static ListenData *_dataManager;
@implementation ListenData

+ (ListenData *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager = [[ListenData alloc] init];
    });
    
    return _dataManager;
}


- (NSMutableArray *)getsListenList{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"t0.png";
        data.title = @"哄睡";
        
////        data.playTime = @"播放";
//        data.playTimes = @"2313123";
        [array addObject:data];
        
    }
    
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"t5";
        data.title = @"托马斯";
//        data.playTimes = @"1111";
//        
        [array addObject:data];
        
    }
    
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"t1.png";
        data.title = @"80后";
        [array addObject:data];
        
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"t2";
        data.title = @"西游记";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"t3";
        data.title = @"双语";
        [array addObject:data];
    }
    
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"t4";
        data.title = @"童话故事";
        [array addObject:data];
    }
    {
        
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"music.png";
        data.title = @"故事";
        [array addObject:data];
        
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"xiangxiangli.png";
        data.title = @"想象力";
        [array addObject:data];
        
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_01";
        data.title = @"记忆力";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_02";
        data.title = @"逻辑思维";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_03";
        data.title = @"情感发展";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_04";
        data.title = @"情感发展";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_05";
        data.title = @"情感发展";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_06";
        data.title = @"情感发展";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"emogi_07";
        data.title = @"情感发展";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"music2";
        data.title = @"情感发展";
        [array addObject:data];
    }

    return array;
}


- (NSMutableArray *)getsMusicData{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
    {
        ListenData  *data = [[ListenData alloc] init];
        data.musicURL = @"http://audio.xmcdn.com/group13/M05/6E/84/wKgDXVc7N33ST3ZuAFIFIhmC6ac098.m4a";
        data.title = @"智慧听";
        [array addObject:data];
    }
    
    {
        ListenData  *data = [[ListenData alloc] init];
        data.musicURL = @"http://audio.xmcdn.com/group16/M06/6E/3E/wKgDalc7NPfDsjEyAF5JwQWHKB0355.m4a";
        data.title = @"聪明先生";
       
        [array addObject:data];
    }
    return array;
}


@end
