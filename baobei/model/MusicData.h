//
//  MusicData.h
//  baobei
//
//  Created by 贺少虎 on 16/5/21.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCommon.h"

@interface MusicData : NSObject <DOUAudioFile>

//@property (nonatomic,strong) MusicData *music;

@property (nonatomic,strong) NSString *musicURL;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *artistName;
@property (nonatomic,strong) NSString *musicPic;

@property (nonatomic,strong) NSURL *audioFileURL;
@property (nonatomic, strong) NSURL *tempFileURL;
@property (nonatomic, strong) NSURL *cacheFileURL;

@end
