//
//  ActivityCell.h
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"
#import "ActivityModel.h"

@protocol ActivityCellDelegate;

@interface ActivityCell : UICollectionViewCell

@property (nonatomic,strong) ActivityModel *activityModel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id <ActivityCellDelegate> delegate;

@end


@protocol ActivityCellDelegate <NSObject>

- (void)selectImageViewListAtIndex:(NSIndexPath *)indexPath data:(ActivityModel *)data;

@end