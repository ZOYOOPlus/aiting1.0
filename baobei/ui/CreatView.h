//
//  CreatView.h
//  baobei
//
//  Created by 张源海 on 16/7/16.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BaseVC.h"
//typedef void (^PassingvalueBlock)(UIImage *Showimage);
@class CreatView;
@protocol PassingValueDelegate <NSObject>

@optional
- (void)viewController:(CreatView *)viewcontroller didPassingValueWithInfo:(id)info;

@end
@interface CreatView : BaseVC
@property (nonatomic, assign) id <PassingValueDelegate>delegate;
@property (nonatomic, assign) NSInteger trailIndex;
@property (nonatomic, strong) NSArray<NSString *> *imgs;

//@property (nonatomic,copy)PassingvalueBlock passingValue;
@end
