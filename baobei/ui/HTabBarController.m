//
//  HTabBarController.m
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HTabBarController.h"
#import "HCommon.h"
#import "HomeVC.h"
#import "LearnVC.h"
#import "PlayVC.h"

#import "ProfilesVC.h"
#import "ShopVC.h"
#import "ProfilesVC.h"
#import "ShowVC.h"
#import "NewsVC.h"
#import "PensonVC.h"

@interface HTabBarController ()

@end
@implementation HTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
     //   [self addChildVC:[[HomeVC alloc] init] title:@"首" image:@"tabbar_home" selectImage:@"tabbar_home_high"];
  //      [self addChildVC:[[LearnVC alloc] init] title:@"学" image:@"tabbar_show" selectImage:@"tabbar_show_high"];
       [self addChildVC:[[LearnVC alloc] init] title:@"学" image:@"tabbar_me" selectImage:@"tabbar_me_high"];       
        [self addChildVC:[[ShowVC alloc] init] title:@"秀" image:@"eye_c1" selectImage:@"eye"];
        [self addChildVC:[[NewsVC alloc] init] title:@"聊" image:@"tabbar_sh" selectImage:@"tabbar_sh_high"];
        [self addChildVC:[[PensonVC alloc] init] title:@"我" image:@"tabbar_show" selectImage:@"tabbar_show_high"];

    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc setTitle:title];

    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.4 green:0.13 blue:0 alpha:1]} forState:UIControlStateSelected];
    
    [self addChildViewController:vc];
}

@end
