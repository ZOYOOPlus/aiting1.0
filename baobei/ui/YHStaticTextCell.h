//
//  YHStaticTextCell.h
//  baobei
//
//  Created by 张源海 on 16/8/1.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**  垂直对齐方向*/
typedef NS_ENUM(NSInteger, VerticalAlignment){

    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom
};
/**
 *  静态文字视图
 *  只提供了简单的文字显示功能
 *  添加了垂直对齐方向属性
 */
@interface YHStaticTextCell : UITableViewCell

/** 文字 */
@property (nonatomic, copy) NSString *text;

/** 文字字体 */
@property (nonatomic, strong) UIFont *font;

/** 文字颜色 */
@property (nonatomic, strong) UIColor *textColor;

/** 水平对齐方向，默认为 NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment alignment;

/** 垂直对齐方向，默认为 VerticalAlignmentMiddle */
@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
