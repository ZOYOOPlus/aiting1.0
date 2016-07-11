//
//  PaintVC.m
//  baobei
//
//  Created by 贺少虎 on 16/5/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>
#import "PaintVC.h"
#import "PaintingView.h"
#import "ImageColorCell.h"
#import "LineLayout.h"
#import "LoginVC.h"

//static NSString *const ID = @"image";
static NSString *const ID = @"button";

@interface PaintVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) PaintingView* paintingView;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) PPSSignatureView *pView;

@property (nonatomic,strong)UIButton *pen1;  // 笔刷 大小
@property (nonatomic,strong)UIButton *pen2;
@property  (nonatomic,strong)UIButton *pen3;
@property (nonatomic,strong)UIButton *saveImage;

@property (nonatomic,strong)UIButton *erase; // 橡皮
@property (nonatomic,strong)UIButton *redraw; // 重绘
@property  (nonatomic,strong)UIButton *undo;  //  回退
@property (nonatomic,strong)UIButton  *goahead; // 前进

// 所有的图片名
//@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) UICollectionView *collectionView;
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

@end

@implementation PaintVC

//- (NSMutableArray *)buttons {
//    if (!_buttons) {
//        self.buttons = [[NSMutableArray alloc] init];
//        for (int i = 1; i <= 20; i++) {
//             UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//            button.tag = 100 + i;
//             NSLog(@"%ld",(long)button.tag);
//            if (button.tag ==101) {
//                button.backgroundColor =[UIColor blackColor];
//            }else if(button.tag ==102) {
//                button.backgroundColor =[UIColor redColor];
//            }else if(button.tag ==103) {
//                button.backgroundColor =[UIColor yellowColor];
//            }else if(button.tag ==104) {
//                button.backgroundColor =[UIColor redColor];
//            }else if(button.tag ==105) {
//                button.backgroundColor =[UIColor whiteColor];
//            }else if(button.tag ==106) {
//                button.backgroundColor =[UIColor grayColor];
//            }else if(button.tag ==107) {
//                button.backgroundColor =[UIColor greenColor];
//            }else if(button.tag ==108) {
//                button.backgroundColor =[UIColor blueColor];
//            }else {
//                button.backgroundColor =[UIColor redColor];
//        }
//            [button addTarget:self action:@selector(ColorClick:) forControlEvents:UIControlEventTouchUpOutside];
//            [self.buttons addObject:button];
//
//    }
//          }return _buttons;
//}
//- (void)ColorClick:(UIButton*)sender{
//    if (sender.tag == 101) {
//        [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 102){
//         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 103){
//         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 104){
//         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 105){
//        [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 106){
//         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 107){
//        [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 108){
//         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else if (sender.tag == 109){
//         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }else {
//        [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
//    }
//    }
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"画图创作";
   //[self.view addSubview:self.pView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton3)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton1)];
    self.navigationItem.leftBarButtonItems = @[item1];

   [self.view addSubview:self.paintingView];
     [self setUp];
    [self setup2];
    [self setupColor];
//    CGFloat w = self.view.frame.size.width;
//    CGRect rect = CGRectMake(0, 500, w, 100);
//    
//    // 创建布局
//    LineLayout *layout = [[LineLayout alloc] init];
//    
//    // 创建CollectionView
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    collectionView.backgroundColor = [UIColor whiteColor];
//    [collectionView registerClass:[ImageColorCell class] forCellWithReuseIdentifier:ID];
//    [self.view addSubview:collectionView];
//    self.collectionView = collectionView;
    
    
    
}
-(void)clickButton3{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"分享" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
    
    [alert show];
}
//#pragma mark - <UICollectionViewDataSource>
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.buttons.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    ImageColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    // button  颜色一直改不掉 啥子问题
//    
//        //cell.backgroundColor = [UIColor blackColor];
//    cell.backgroundColor  = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(200)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//
//        //cell.button = self.buttons[indexPath.item];
//    return cell;
//}
//
//#pragma mark - <UICollectionViewDelegate>
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//}



-(void)clickButton1{
    [self.view setUserInteractionEnabled:YES];
    if ([AVUser currentUser] != NULL){
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
    
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 2秒后异步执行这里的代码...
        [self.navigationController popViewControllerAnimated:YES];
    });}else{
    
    [self.navigationController popViewControllerAnimated:YES];
        }
}
-(void)setupColor{
    _color1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //  RGB( 0, 0, 255) 蓝色
    _color1.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1];
    [_color1 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color1 setTag:21];
    _color1.layer.cornerRadius = 20;
    _color1.layer.masksToBounds = true;
    _color1.layer.borderWidth = 0.0;
    [self.view addSubview:_color1];
    
    _color2 = [UIButton buttonWithType:UIButtonTypeCustom];
   // RGB( 0, 255, 0) 绿色
  _color2.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1];
    [_color2 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color2 setTag:22];
    _color2.layer.cornerRadius = 20;
    _color2.layer.masksToBounds = true;
    _color2.layer.borderWidth = 0.0;
    [self.view addSubview:_color2];
    
    _color3 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 255, 0, 0) 红色
 _color3.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    [_color3 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color3 setTag:23];
    _color3.layer.cornerRadius = 20;
    _color3.layer.masksToBounds = true;
    _color3.layer.borderWidth = 0.0;
    [self.view addSubview:_color3];
    
    _color4 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 255, 255, 0) 黄色
 _color4.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1];
    [_color4 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color4 setTag:24];
    _color4.layer.cornerRadius = 20;
    _color4.layer.masksToBounds = true;
    _color4.layer.borderWidth = 0.0;
    [self.view addSubview:_color4];
    
    _color5 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 0, 0, 128) 暗蓝色
     _color5.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:123.0/255.0 alpha:1];
    [_color5 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color5 setTag:25];
    _color5.layer.cornerRadius = 20;
    _color5.layer.masksToBounds = true;
    _color5.layer.borderWidth = 0.0;
    [self.view addSubview:_color5];
    
    _color6 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 255, 0, 255) 品红色
       _color6.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1];
    [_color6 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color6 setTag:26];
    _color6.layer.cornerRadius = 20;
    _color6.layer.masksToBounds = true;
    _color6.layer.borderWidth = 0.0;
    [self.view addSubview:_color6];
    
    _color7 = [UIButton buttonWithType:UIButtonTypeCustom];
   // RGB( 0, 128, 0) 暗绿色
    _color7.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];
    [_color7 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color7 setTag:27];
    _color7.layer.cornerRadius = 20;
    _color7.layer.masksToBounds = true;
    _color7.layer.borderWidth = 0.0;
    [self.view addSubview:_color7];
    
    _color8 = [UIButton buttonWithType:UIButtonTypeCustom];
   //RGB( 0, 128, 128) 暗青色
    _color8.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1];
    [_color8 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color8 setTag:28];
    _color8.layer.cornerRadius = 20;
    _color8.layer.masksToBounds = true;
    _color8.layer.borderWidth = 0.0;
    [self.view addSubview:_color8];
    
    _color9 = [UIButton buttonWithType:UIButtonTypeCustom];
   
    //RGB( 128, 0, 0) 暗红色
    _color9.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    [_color9 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color9 setTag:29];
    _color9.layer.cornerRadius = 20;
    _color9.layer.masksToBounds = true;
    _color9.layer.borderWidth = 0.0;
    [self.view addSubview:_color9];
    
    _color10 = [UIButton buttonWithType:UIButtonTypeCustom];
    //RGB( 128, 0, 128) 暗紫色
    _color10.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:128.0/255.0 alpha:1];
    [_color10 addTarget:self action:@selector(Colorclick:) forControlEvents:UIControlEventTouchUpInside];
    [_color10 setTag:30];
    _color10.layer.cornerRadius = 20;
    _color10.layer.masksToBounds = true;
    _color10.layer.borderWidth = 0.0;
    [self.view addSubview:_color10];
    
    [_color1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-65);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(100);
        make.bottom.equalTo(self.view.mas_bottom).offset(-65);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(170);
        make.bottom.equalTo(self.view.mas_bottom).offset(-65);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(240);
        make.bottom.equalTo(self.view.mas_bottom).offset(-65);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(310);
        make.bottom.equalTo(self.view.mas_bottom).offset(-65);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_color6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(100);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(170);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(240);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_color10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(310);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

}
-(void)Colorclick:(UIButton*)sender{
    if(sender.tag == 21){
        [_paintingView setBrushColorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 opacity:1.0];
    }else if(sender.tag == 22){
        [_paintingView setBrushColorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 opacity:1.0];
    }else if(sender.tag == 23){
        [_paintingView setBrushColorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 opacity:1.0];
    }else if(sender.tag == 24){
        [_paintingView setBrushColorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0  opacity:1.0];
    }else if(sender.tag == 25){
        [_paintingView setBrushColorWithRed:0.0/255.0 green:0.0/255.0 blue:123.0/255.0 opacity:1.0];
    }else if(sender.tag == 26){
        [_paintingView setBrushColorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 opacity:1.0];
    }else if(sender.tag == 27){
        [_paintingView setBrushColorWithRed:0.0/255.0 green:128.0/255.0 blue:0.0/255.0 opacity:1.0];
    }else if(sender.tag == 28){
        [_paintingView setBrushColorWithRed:0.0/255.0 green:128.0/255.0 blue:128.0/255.0 opacity:1.0];
    }else if(sender.tag == 29){
        [_paintingView setBrushColorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 opacity:1.0];
    }else{
        [_paintingView setBrushColorWithRed:128.0/255.0 green:0.0/255.0 blue:128.0/255.0 opacity:1.0];
    }
}

- (void)setUp{
    _pen1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _pen1.backgroundColor = [UIColor blackColor];
    [_pen1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_pen1 setTag:11];
    _pen1.layer.cornerRadius = 15;
    _pen1.layer.masksToBounds = true;
    _pen1.layer.borderWidth = 0.0;
    [self.view addSubview:_pen1];
    
    _pen2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _pen2.backgroundColor = LOCAL_COLOR[1];
    _pen2.layer.cornerRadius = 17.5;
    _pen2.layer.masksToBounds = true;
    _pen2.layer.borderWidth = 0.0;
    [_pen2 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_pen2 setTag:12];
    [self.view addSubview:_pen2];
    
    _pen3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _pen3.backgroundColor = LOCAL_COLOR[2];
    _pen3.layer.cornerRadius = 25;
    _pen3.layer.masksToBounds = true;
    _pen3.layer.borderWidth = 0.0;
    [_pen3 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_pen3 setTag:13];
    [self.view addSubview:_pen3];
    
    _saveImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveImage.backgroundColor = [UIColor clearColor];
    _pen3.layer.cornerRadius = 25;
    _pen3.layer.masksToBounds = true;
    _pen3.layer.borderWidth = 0.0;
    [_saveImage setTitle:@"保存" forState:UIControlStateNormal];
    [_saveImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveImage addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_saveImage setTag:20];
    [self.view addSubview:_saveImage];
    
    
    [_pen1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(self.paintingView).offset(-35);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_pen2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(70);
        make.top.equalTo(self.paintingView).offset(-40);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [_pen3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(120);
        make.top.equalTo(self.paintingView).offset(-50);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_saveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.paintingView).offset(-50);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    
}

-(void)setup2{
    _redraw= [UIButton buttonWithType:UIButtonTypeCustom];
//    _redraw.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chonghui.png"]];
    [_redraw setBackgroundImage:[UIImage imageNamed:@"chonghui.png"] forState:UIControlStateNormal];
    [_redraw addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_redraw setTag:14];
    
    [self.view addSubview:_redraw];
    
    _undo = [UIButton buttonWithType:UIButtonTypeCustom];
//    _undo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qianjin.png"]];
 //   [_undo setBackgroundImage:[UIImage imageNamed:@"qianjin.png"] forState:UIControlStateNormal];
    
 //  [_undo addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_undo setTag:15];
    [self.view addSubview:_undo];
    
    _goahead = [UIButton buttonWithType:UIButtonTypeCustom];
//    _goahead.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"houtui.png"]];
  //  [_goahead setBackgroundImage:[UIImage imageNamed:@"houtui.png"] forState:UIControlStateNormal];
    //[_goahead addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_goahead setTag:16];
    [self.view addSubview:_goahead];
    
    _erase = [UIButton buttonWithType:UIButtonTypeCustom];
//    _erase.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xiangpi"]];
    [_erase setBackgroundImage:[UIImage imageNamed:@"xiangpi.png"] forState:UIControlStateNormal];
    [_erase addTarget:self action:@selector(nextclickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_erase setTag:17];
    [self.view addSubview:_erase];
    
    [_redraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.bottom.equalTo(self.paintingView).offset(45);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_undo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(125);
        make.bottom.equalTo(self.paintingView).offset(45);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_goahead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(225);
        make.bottom.equalTo(self.paintingView).offset(45);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_erase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(325);
        make.bottom.equalTo(self.paintingView).offset(45);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

}
- (void)nextclickButton:(UIButton*)sender{
    if (sender.tag == 14) {
//      [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
   [_paintingView erase];
        [_paintingView  setNeedsDisplay];
    }else if(sender.tag == 15){
        [_paintingView erase];
        [_paintingView  setNeedsDisplay];
    }else if (sender.tag == 16){
        [_paintingView location];
        [_paintingView  setNeedsDisplay];
    }else if (sender.tag == 17){
      [_paintingView setBrushColorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 opacity:1.0];
        
        [_paintingView  setNeedsDisplay];
    }
}
- (void)clickButton:(UIButton*)sender{
    if(sender.tag == 11){
         [_paintingView setBrushColorWithRed:236.0/255.0 green:11.0/255.0 blue:25.0/255.0 opacity:1.0];
    }else if(sender.tag == 12){
         [_paintingView setBrushColorWithRed:251.0/255.0 green:160.0/255.0 blue:40.0/255.0 opacity:1.0];
    }else if(sender.tag == 13){
        [_paintingView setBrushColorWithRed:254.0/255.0 green:244.0/255.0 blue:40.0/255.0 opacity:1.0];
    }else{
        [ self clickButton10];
    }
}









- (PaintingView *)paintingView{
    if (!_paintingView) {
  _paintingView = [[PaintingView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height*(0.6))];
        _paintingView.backgroundColor = [UIColor whiteColor];
        _paintingView.opaque = YES;
        
        _paintingView.clearsContextBeforeDrawing = YES;
        [_paintingView initBrush:2];
        [_paintingView setBrushColorWithRed:0 green:0 blue:0 opacity:255];
       // [_paintingView setBackgroundColor:[UIColor whiteColor]];
        [_paintingView changePen:2 :0.3];
//  _paintingView = [[PaintingView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height*(0.6 ))context:context];
//        _paintingView = [[PaintingView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height*(0.6))];
//
//        if ([AVUser currentUser] != NULL) {
//            _paintingView.clearsContextBeforeDrawing = NO;
//            AVFile* file = [[AVUser currentUser] objectForKey:@"panitingImage"];
//            if(file != NULL){
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:file.url]];
//                    UIImage *image = [[UIImage alloc]initWithData:data];
//                    if (data != nil) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            //在这里做UI操作(UI操作都要放在主线程中执行)
//                            [_paintingView setImage:image];
//                        });  
//                    }  
//                });
//                
//            }
//            
//        }
//        
//
//        [_paintingView setImage:[PaintVC createImageWithColor:[UIColor grayColor]]];
    }
    return _paintingView;
}

- (PPSSignatureView *)pView{
    if (!_pView) {
        EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
        [EAGLContext setCurrentContext:context];

//        _pView = [[PPSSignatureView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height*(0.6 ))context:context];
    }
    return _pView;
}

- (void)clickButton10{
    [self.view setUserInteractionEnabled:YES];
//    UIAlertView *alertView = [[UIAlertView alloc]
//                              initWithTitle:NULL message:@"保存成功！" delegate:NULL
//                              cancelButtonTitle:@"确定" otherButtonTitles:NULL];
//    [alertView show];
    
   // self.pView.strokeColor = [UIColor blackColor];
    
    UIGraphicsBeginImageContextWithOptions(self.paintingView.bounds.size, NO, 0.0);
    
    //  获取图形上下文
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    //  截屏
    [self.paintingView.layer renderInContext:cxt];
    
    //  获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();

      UIImageWriteToSavedPhotosAlbum(self.paintingView.getImage, self, @selector(image:didFinishSavingWithError:contextInfo:), @"哈哈哈哈哈");
    if([AVUser currentUser] != NULL){
        WEAKSELF
        [self.view setUserInteractionEnabled:NO];
//        NSData* imageData = UIImageJPEGRepresentation( weakSelf. pView.signatureImage, 0.2);
//        UIImageWriteToSavedPhotosAlbum(self.pView.signatureImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        NSData* imageData = UIImageJPEGRepresentation(_paintingView.getImage, 0.2);
       // AVFile* imageFile = [AVFile fileWithData:imageData];
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

//-(void)viewWillDisappear:(BOOL)animated
//{
//    UIAlertView *alertView1 = [[UIAlertView alloc]
//                              initWithTitle:NULL message:@"是否保存图画" delegate:NULL
//                              cancelButtonTitle:@"确定" otherButtonTitles:NULL];
//    [self.view setUserInteractionEnabled:YES];
//    [alertView1 show];
//    [self clickButton];
//}
@end
