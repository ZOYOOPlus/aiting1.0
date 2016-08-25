//
//  AppDelegate.h
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCommon.h"

@class ViewController;




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key;
   

@end

