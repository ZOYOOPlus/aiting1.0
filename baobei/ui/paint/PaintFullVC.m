//
//  PaintFullVC.m
//  baobei
//
//  Created by 张源海 on 16/7/20.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "PaintFullVC.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>
#import "PaintVC.h"
#import "PaintingView.h"
#import "ImageColorCell.h"
#import "LineLayout.h"
#import "LoginVC.h"
#import "HomeVC.h"
#import "creatVC.h"
#import "TableVC.h"
#import "HCommon.h"
#import "UIImage+FloodFill.h"
#import "FloodFillImageView.h"
#import "LinkedListStack.h"
#import "CreatView.h"
#import "CreateCell.h"
#import "HImageListCell.h"
//static NSString *const ID = @"image";
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
static NSString *const ID = @"button";
@interface PaintFullVC ()<PassingValueDelegate>

@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong ) FloodFillImageView *iconView;


@property (nonatomic,strong)UIButton *pen1;  // 笔刷 大小
@property (nonatomic,strong)UIButton *pen2;
@property  (nonatomic,strong)UIButton *pen3;
@property (nonatomic,strong)UIButton *saveImage;

@property (nonatomic,strong)UIButton *eraser; // 橡皮
@property (nonatomic,strong)UIButton *redraw; // 重绘
@property  (nonatomic,strong)UIButton *undo;  //  回退
@property (nonatomic,strong)UIButton  *goahead; // 前进
@property (nonatomic,strong)UIButton  *Upload; // 上传
@property (nonatomic, strong)NSMutableArray *buttons;
//添加各种颜色的 按钮

@property (nonatomic,strong)UIButton *color1;
@property (nonatomic,strong)UIButton *color2;
@property (nonatomic,strong)UIButton *color3;
@property (nonatomic,strong)UIButton *color4;
@property (nonatomic,strong)UIButton *color5;
@property (nonatomic,strong)UIButton *color6;
@property (nonatomic,strong)UIButton *color7;
@property (nonatomic,strong)UIButton *color8;
@property (nonatomic,strong)UIButton *color9;
@property (nonatomic,strong)UIButton *color10;

@property (strong, nonatomic)  UITextField *txtTolerance;

@property (nonatomic,strong)UIButton *btnSetTap;
@property (nonatomic,strong)UIButton *btnColorTap;
@end

@implementation PaintFullVC

@synthesize txtTolerance;

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    self.iconView.image = icon;
//    [self.iconView setNeedsDisplay];
 //   _iconView.frame = CGRectMake(0, 50, fDeviceWidth, fDeviceWidth);
    _iconView.bounds = CGRectMake(0, 50, fDeviceWidth, fDeviceWidth);
    NSLog(@"%@========%@",self.iconView, self);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"-------------%@---------%@", self.iconView, self);
    
    
    self.iconView.newcolor = [UIColor redColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];
    self.title = @"填色";
    
      [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:22],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton3)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton1)];
    self.navigationItem.leftBarButtonItems = @[item1];
    


    
    [self.view addSubview:self.iconView];
    // 笔头大小
    self.iconView.tolorance = 5;
    self.iconView.newcolor = [UIColor  redColor];
    


    self.iconView.userInteractionEnabled = YES;
    [self setUp];
    [self setup2];
    [self setupColor];
}



-(void)clickButton3{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"分享" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
    
    [alert show];
}


-(void)clickButton1{
    [self.view setUserInteractionEnabled:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    if ([AVUser currentUser] != NULL){
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存图片"  preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        
//        [alertController addAction:sureAction];
//        [alertController addAction:cancelAction];
//        [self.parentViewController presentViewController:alertController animated:YES completion:^{
//            
//        }];
//    }else{
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存图片"  preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }];
//        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        
//        [alertController addAction:sureAction];
//        [alertController addAction:cancelAction];
//        
//        [self.parentViewController presentViewController:alertController animated:YES completion:^{
//            
 //       }];
  //  }
}

-(void)clickButton5{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupColor{
    _color1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //  RGB( 0, 0, 255) 蓝色
    _color1.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:12.0/255.0 blue:26.0/255.0 alpha:1];
    [_color1 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color1 setTag:21];
    _color1.layer.cornerRadius = 25;
    _color1.layer.masksToBounds = true;
    _color1.layer.borderWidth = 0.0;
    [self.view addSubview:_color1];
    
    _color2 = [UIButton buttonWithType:UIButtonTypeCustom];
    // RGB( 0, 255, 0) 绿色
    _color2.backgroundColor = [UIColor colorWithRed:248/255.0 green:160.0/255.0 blue:39.0/255.0 alpha:1];
    [_color2 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color2 setTag:22];
    _color2.layer.cornerRadius = 25;
    _color2.layer.masksToBounds = true;
    _color2.layer.borderWidth = 0.0;
    [self.view addSubview:_color2];
    
    _color3 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 255, 0, 0) 红色
    _color3.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:243.0/255.0 blue:39.0/255.0 alpha:1];
    [_color3 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color3 setTag:23];
    _color3.layer.cornerRadius = 25;
    _color3.layer.masksToBounds = true;
    _color3.layer.borderWidth = 0.0;
    [self.view addSubview:_color3];
    _color4 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 255, 255, 0) 黄色
    _color4.backgroundColor = [UIColor colorWithRed:158.0/255.0 green:197.0/255.0 blue:38.0/255.0 alpha:1];
    [_color4 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color4 setTag:24];
    _color4.layer.cornerRadius = 25;
    _color4.layer.masksToBounds = true;
    _color4.layer.borderWidth = 0.0;
    [self.view addSubview:_color4];
    
    _color5 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 0, 0, 128) 暗蓝色
    _color5.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:151.0/255.0 blue:46.0/255.0 alpha:1];
    [_color5 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color5 setTag:25];
    _color5.layer.cornerRadius = 25;
    _color5.layer.masksToBounds = true;
    _color5.layer.borderWidth = 0.0;
    [self.view addSubview:_color5];
    
   
    
    //  五个颜色  滑动   屏幕的宽度/5  适配
    if ([UIScreen mainScreen].bounds.size.width== 320){
    
    [_color1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_color2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5+10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_color3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5+fDeviceWidth/5+10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_color4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*3+10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_color5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*4+10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    }else{
        [_color1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(10);
            make.bottom.equalTo(self.view.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [_color2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5+10);
            make.bottom.equalTo(self.view.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [_color3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5+fDeviceWidth/5+10);
            make.bottom.equalTo(self.view.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [_color4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*3+10);
            make.bottom.equalTo(self.view.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [_color5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*4+10);
            make.bottom.equalTo(self.view.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];

    
    }
    
  
}
-(void)Colorclick:(UIButton*)sender{
    if(sender.tag == 21){
        
          self.iconView.newcolor  = [UIColor  colorWithRed:235.0/255.0 green:12.0/255.0 blue:26.0/255.0 alpha:1];
    }else if(sender.tag == 22){
        self.iconView.newcolor  = [UIColor  colorWithRed:248.0/255.0 green:160.0/255.0 blue:39.0/255.0 alpha:1];
    }else if(sender.tag == 23){
        self.iconView.newcolor  = [UIColor  colorWithRed:252.0/255.0 green:243.0/255.0 blue:39.0/255.0 alpha:1];
    }else if(sender.tag == 24){
        self.iconView.newcolor  = [UIColor  colorWithRed:158.0/255.0 green:197.0/255.0 blue:38.0/255.0 alpha:1];
    }else if(sender.tag == 25){
        self.iconView.newcolor  = [UIColor  colorWithRed:20.0/255.0 green:151.0/255.0 blue:46.0/255.0 alpha:1];
    }

}

- (void)setUp{
    _pen1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _pen1.backgroundColor = [UIColor orangeColor];
    [_pen1 addTarget:self action:@selector(clickPenButton:) forControlEvents:UIControlEventTouchUpInside];
    [_pen1 setTag:11];
    _pen1.layer.cornerRadius = 8;
    _pen1.layer.masksToBounds = true;
    _pen1.layer.borderWidth = 0.0;
    [self.view addSubview:_pen1];
    
    _pen2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _pen2.backgroundColor = [UIColor orangeColor];
    _pen2.layer.cornerRadius = 12;
    _pen2.layer.masksToBounds = true;
    _pen2.layer.borderWidth = 0.0;
    [_pen2 addTarget:self action:@selector(clickPenButton:) forControlEvents:UIControlEventTouchUpInside];
    [_pen2 setTag:12];
    [self.view addSubview:_pen2];
    
    _pen3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _pen3.backgroundColor = [UIColor orangeColor];
    _pen3.layer.cornerRadius = 16;
    _pen3.layer.masksToBounds = true;
    _pen3.layer.borderWidth = 0.0;
    [_pen3 addTarget:self action:@selector(clickPenButton:) forControlEvents:UIControlEventTouchUpInside];
    [_pen3 setTag:13];
    [self.view addSubview:_pen3];
    
    _saveImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveImage setImage:[UIImage imageNamed:@"创作7_03.png"] forState:UIControlStateNormal];
    [_saveImage setTitle:@"保存" forState:UIControlStateNormal];
    [_saveImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveImage addTarget:self action:@selector(clickButton6:) forControlEvents:UIControlEventTouchUpInside];
    [_saveImage setTag:20];
    [self.view addSubview:_saveImage];
    
    
    [_pen1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.bottom.equalTo(self.iconView.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [_pen2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(70);
        make.bottom.equalTo(self.iconView.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [_pen3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(120);
        make.bottom.equalTo(self.iconView.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    [_saveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.iconView).offset(-40);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
}

-(void)setup2{
    

    _redraw= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_redraw setBackgroundImage:[UIImage imageNamed:@"创作7_10.png"] forState:UIControlStateNormal];
    [_redraw addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_redraw setTag:14];
    
    [self.view addSubview:_redraw];
    
    _undo = [UIButton buttonWithType:UIButtonTypeCustom];
    _undo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qianjin.png"]];
    [_undo setBackgroundImage:[UIImage imageNamed:@"创作7_13.png"] forState:UIControlStateNormal];
    
    [_undo addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_undo setTag:15];
    [self.view addSubview:_undo];
    
    _goahead = [UIButton buttonWithType:UIButtonTypeCustom];
    _goahead.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"houtui.png"]];
    [_goahead setBackgroundImage:[UIImage imageNamed:@"创作7_15.png"] forState:UIControlStateNormal];
    [_goahead addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_goahead setTag:16];
    [self.view addSubview:_goahead];
    
    _eraser = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _erase.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xiangpi"]];
    [_eraser setBackgroundImage:[UIImage imageNamed:@"创作7_07.png"] forState:UIControlStateNormal];
    [_eraser addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_eraser setTag:17];
    [self.view addSubview:_eraser];
    
    _Upload = [UIButton buttonWithType:UIButtonTypeCustom];
    [_Upload setImage:[UIImage imageNamed:@"创作7_18.png"] forState:UIControlStateNormal];
    [_Upload addTarget:self action:@selector(clickButton10) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_Upload];
    
    
    //   屏幕的宽度/5  适配
        if ([UIScreen mainScreen].bounds.size.width== 320){
    
    [_redraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_undo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5+10);
        //        make.bottom.equalTo(self.paintingView).offset(45);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_goahead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*2+10);
        //        make.bottom.equalTo(self.paintingView).offset(45);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_eraser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*3+10);
        //    make.bottom.equalTo(self.paintingView).offset(45);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_Upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*4+10);
        //  make.bottom.equalTo(self.paintingView).offset(40);
        make.top.equalTo(self.iconView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
        }else{
        
            [_redraw mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(10);
                make.top.equalTo(self.iconView.mas_bottom).offset(20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            [_undo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5+10);
                //        make.bottom.equalTo(self.paintingView).offset(45);
                make.top.equalTo(self.iconView.mas_bottom).offset(20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            [_goahead mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*2+10);
                //        make.bottom.equalTo(self.paintingView).offset(45);
                make.top.equalTo(self.iconView.mas_bottom).offset(20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            [_eraser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*3+10);
                //    make.bottom.equalTo(self.paintingView).offset(45);
                make.top.equalTo(self.iconView.mas_bottom).offset(20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            
            [_Upload mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(fDeviceWidth/5*4+10);
                //  make.bottom.equalTo(self.paintingView).offset(40);
                make.top.equalTo(self.iconView.mas_bottom).offset(25);
                make.size.mas_equalTo(CGSizeMake(60, 40));
            }];
        
        
        }
}
- (void)nextclickButton:(UIButton*)sender{
    if (sender.tag == 14) {

       
    
        self.iconView.image = _icon;
        [self.iconView setNeedsDisplay];

    }else if(sender.tag == 15){
       
    }else if (sender.tag == 16){

    }else if (sender.tag == 17){

        self.iconView.newcolor =[UIColor whiteColor];
        [self.iconView setNeedsDisplay];
    }
}
// 回退
//- (void) playback:(NSMutableArray*)recordedPaths
//{
//    NSData*				data = [recordedPaths objectAtIndex:0];
//    CGPoint*			point = (CGPoint*)[data bytes];
//    NSUInteger			count = [data length] / sizeof(CGPoint),
//    i;
//
//    // Render the current path
//    for(i = 0; i < count - 1; ++i, ++point)
//        [self.paintingView renderLineFromPoint:*point toPoint:*(point + 1)];
//
//    // Render the next path after a short delay
//    [recordedPaths removeObjectAtIndex:0];
//    if([recordedPaths count])
//        [self performSelector:@selector(playback:) withObject:recordedPaths afterDelay:0.01];
//}

// 设置线条粗细
- (void)clickPenButton:(UIButton*)sender{
    if(sender.tag == 11){
        self.iconView.tolorance = 10;
      //  glPointSize( kBrushScale_5);
    }else if(sender.tag == 12){
       // glPointSize( kBrushScale_13);
        self.iconView.tolorance = 20;
    }else if(sender.tag == 13){
//        glPointSize( kBrushScale_20);
        self.iconView.tolorance = 100;
    }
}

- (void)clickButton6:(UIButton*)sender{
    
    creatVC *creatVC1= [[creatVC  alloc]init];
    
    [self.navigationController pushViewController:creatVC1 animated:YES];
}


- (FloodFillImageView *)iconView{
    if (_iconView == nil) {
//        if ([UIScreen mainScreen].bounds.size.width== 320) {
////            _ImageView = [[FloodFillImageView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height*(0.58))];
//              _iconView = [[FloodFillImageView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.width)];
//        }else{
//            _ImageView = [[FloodFillImageView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height*(0.62))];
        // 无法传值的问题  来自 创建的时候 不是同一个View  
                _iconView = [[FloodFillImageView alloc]initWithFrame:CGRectMake(0, 50, fDeviceWidth, fDeviceWidth)];
//        }
    
         _iconView.newcolor = [UIColor redColor];

    }
    return _iconView;
}

- (void)clickButton10{
    [self.view setUserInteractionEnabled:YES];
   
    
    // self.pView.strokeColor = [UIColor blackColor];
    
    UIGraphicsBeginImageContextWithOptions(self.iconView.bounds.size, NO, 0.0);
    
    //  获取图形上下文
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    //  截屏
    [self.iconView.layer renderInContext:cxt];
    
    //  获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(self.iconView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"哈哈哈哈哈");
    if([AVUser currentUser] != NULL){
        WEAKSELF
        [self.view setUserInteractionEnabled:NO];
    
        
        NSData* imageData = UIImageJPEGRepresentation(self.iconView.image, 0.2);
        AVFile* imageFile = [AVFile fileWithData:imageData];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error == NULL && succeeded) {
                [[AVUser currentUser] setObject:imageFile forKey:@"panitingImage"];
                [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded1, NSError *error1) {
                    if (error1 == NULL && succeeded1) {
                        [self.view setUserInteractionEnabled:YES];
                        UIAlertView *alertView = [[UIAlertView alloc]
                                                  initWithTitle:NULL message:@"保存成功！" delegate:NULL
                                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
                        [alertView show];
                    }else{
                        [self.view setUserInteractionEnabled:YES];
                        UIAlertView *alertView = [[UIAlertView alloc]
                                                  initWithTitle:NULL message:@"保存失败，请稍后再试！" delegate:NULL
                                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
                        [alertView show];
                    }
                }];
                
            }else{
                [self.view setUserInteractionEnabled:YES];
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:NULL message:@"保存失败，请稍后再试！" delegate:NULL
                                          cancelButtonTitle:@"确定" otherButtonTitles:NULL];
                [alertView show];
            }
        }];
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"登录账号才可以分享！" delegate:NULL
                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
        
        LoginVC *Lgvc = [[LoginVC alloc]init];
        [self.navigationController pushViewController:Lgvc animated:YES]; //跳转到下一页面
        
    }
    
}
// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        NSLog(@"save success");
    }else{
        NSLog(@"save failed");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (UIImage*)createImageWithColor:(UIColor*)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,[color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}


@end
