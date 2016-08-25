//
//  YHZoomPickerView.h
//  baobei
//
//  Created by 张源海 on 16/8/1.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHZoomPickerViewDelegate;
@protocol YHZoomPickerViewDataSource ;


@interface YHZoomPickerView : UIView

/** 代理 */
@property (nonatomic,strong) id<YHZoomPickerViewDelegate>delegate;
/** 数据源 */
@property (nonatomic,strong) id<YHZoomPickerViewDataSource>dataSource;

/** 当前行上方显示行数，默认2 */
@property (nonatomic, assign) NSUInteger topRowCount;

/** 当前行下方显示行数，默认2 */
@property (nonatomic, assign) NSUInteger bottomRowCount;

/** 当前选中行的序号，通过此属性选择行，将没有动画效果 */
@property (nonatomic, assign) NSUInteger selectedRow;

/** 行高，默认20 */
@property (nonatomic, assign) CGFloat rowHeight;

/** 当前选中行的字体 */
@property (nonatomic, strong) UIFont *selectedRowFont;

/** 字体颜色，默认黑色 */
@property (nonatomic, strong) UIColor *textColor;

/** 未选中行的字体缩放比例，范围：[0, 1]，默认0.5 */
@property (nonatomic, assign) CGFloat unselectedRowScale;

/** 行数量 */
@property (nonatomic, readonly, assign) NSUInteger rowCount;

/** CLZoomPickerView实际占用的高度 */
@property (nonatomic, readonly, assign) CGFloat fitHeight;


/** 重新加载数据源 */
- (void)reloadData;

/** 通过行序号，选择指定行 */
- (void)selectRow:(NSInteger)row animated:(BOOL)animated;


@end
