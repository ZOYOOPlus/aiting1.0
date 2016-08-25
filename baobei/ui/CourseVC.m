//
//  CourseVC.m
//  baobei
//
//  Created by 贺少虎 on 16/5/18.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "CourseVC.h"

@interface CourseVC ()

@end

@implementation CourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程";
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"K_demo.jpg"]];
    [self.view addSubview:image];
    image.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
