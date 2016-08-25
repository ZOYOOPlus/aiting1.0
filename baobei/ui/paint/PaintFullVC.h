//
//  PaintFullVC.h
//  baobei
//
//  Created by 张源海 on 16/7/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
typedef void (^PassingvalueBlock)(UIImage *Showimage);
@interface PaintFullVC : UIViewController

@property (nonatomic,copy)PassingvalueBlock passingValue;

@property (nonatomic,strong) UIImage *icon;

//- (void)PassingValue:(PassingvalueBlock)block;
@end
