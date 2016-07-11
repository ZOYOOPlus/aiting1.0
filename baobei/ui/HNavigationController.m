//
//  HNavigationController.m
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HNavigationController.h"

@interface HNavigationController ()

@end

@implementation HNavigationController

+ (void)initialize
{
    if (self == [HNavigationController class]) {
        NSMutableDictionary *titleTextAttrs = [NSMutableDictionary dictionary];
        titleTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.4 green:0.13 blue:0 alpha:1];
        titleTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];

        UINavigationBar *bar = [UINavigationBar appearance];
        UIImage * image = [HUtil createImageWithColor:[UIColor colorWithHexString:@"#FFDA1F"]];
        [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [bar setShadowImage: [[UIImage alloc] init]];
        [bar setTitleTextAttributes:titleTextAttrs];
        bar.tintColor = [UIColor whiteColor];
        
        
        UIBarButtonItem *item = [UIBarButtonItem appearance];

        
            NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
            textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.4 green:0.13 blue:0 alpha:1];
            textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
            [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            item.tintColor = [UIColor whiteColor];
        
        
        bar.titleTextAttributes =textAttrs;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
//    NSDictionary *dict=[NSDictionary dictionaryWithObjects:
//                        [NSArray arrayWithObjects:[UIColor whiteColor],[UIFont boldSystemFontOfSize:17],[UIColor clearColor],nil]
//                                                   forKeys:
//                        [NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
//    self.navigationController.navigationBar.titleTextAttributes=dict;
    
}



@end
