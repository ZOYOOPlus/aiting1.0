//
//  DataManager.h
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"
#import "HCommon.h"
#import "ListenCell.h"

@interface DataManager : NSObject{


}

@property (nonatomic, weak) ListenCell *listenCell;

+ (DataManager *)shareInstance;

// ui test
- (NSMutableArray *)getAdsArray;
- (NSMutableArray *)getLearnAdsArray;
- (NSMutableArray *)getActivityData;
- (NSArray *)getActivityTitleData;
- (NSMutableArray *)getProfileConfigArray;

- (NSMutableArray *)getShopAdsArray;
- (NSMutableArray *)getListenList;
- (NSMutableArray *)getVideoList;

- (NSMutableArray *)getMusicData;

- (NSMutableArray *)getOtherMusicData;

@end
