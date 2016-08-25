//
//  creatVC.m
//  baobei
//
//  Created by 张源海 on 16/7/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "creatVC.h"
#import "PaintVC.h"
#import "CreatView.h"
#import "CreateCell.h"
#import "PaintFullVC.h"
static NSString *celllD = @"HImageListCell";

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
#define kItemWidthHeigthScale 1.06 //长宽比
@interface creatVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIButton *Btn1;
@property(nonatomic,strong)UIButton *Btn2;
@property(nonatomic,strong)UIButton *Btn3;
@property(nonatomic,strong)UIButton *Btn4;
@property(nonatomic,strong)UIButton *Btn5;
@property(nonatomic,strong)UIButton *Btn6;

@property(nonatomic,strong)UIImageView *Image1;
@property(nonatomic,strong)UIImageView *Image2;
@property(nonatomic,strong)UIImageView *Image3;
@property(nonatomic,strong)UIImageView *Image4;
@property(nonatomic,strong)UIImageView *Image5;
@property(nonatomic,strong)UIImageView *Image6;

@property (nonatomic,strong)UILabel  *label1;
@property (nonatomic,strong)UILabel  *label2;
@property (nonatomic,strong)UILabel  *label3;
@property (nonatomic,strong)UILabel  *label4;
@property (nonatomic,strong)UILabel  *label5;
@property (nonatomic,strong)UILabel  *label6;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectType;

@end

@implementation creatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题";
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton01)];
    self.navigationItem.leftBarButtonItems = @[item1];
   [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor  whiteColor];
//    [self setupBtn];
//    [self setupImage];
    //    [self setupLabel];[self.view addSubview:self.collectionView];
  //  [self addHeadView];
    self.selectType = 1;
}
- (void)clickButton01{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setSelectType:(NSInteger)selectType{
    if (_selectType == selectType) {
        return;
    }
    _selectType = selectType;
    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        CGFloat width = self.view.width/2 - 10 - 5;
        layout.itemSize = CGSizeMake(width , width * kItemWidthHeigthScale);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 66, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 66 ) collectionViewLayout:layout];
        [_collectionView registerClass:[CreateCell class] forCellWithReuseIdentifier:celllD];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}
#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
   if (indexPath.row == 5){
        [self  backPaint];
    }else{
    
        CreatView *loVC = [[CreatView  alloc]init];
        loVC.trailIndex = indexPath.item;
        loVC.imgs = @[@"", @""];
        [self.navigationController pushViewController:loVC animated:YES];
    }
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CreateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celllD forIndexPath:indexPath];
    
    
    if (self.selectType == 1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"AR.png"];
            ;
            cell.userName.text = @"AR";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"Map03_1.jpg"];
            cell.userName.text = @"秘密花园";
        } else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"Map02_2.jpg"];
            cell.userName.text = @"植物";
        }else if (indexPath.row == 3){
            cell.imageView.image = [UIImage imageNamed:@"Map03_3.jpg"];
            cell.userName.text = @"动物";
        }else  if (indexPath.row == 4){
            cell.imageView.image = [UIImage imageNamed:@"Map01_4.jpg"];
            cell.userName.text = @"建筑";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"hua01.jpg"];
             cell.userName.text = @"自由创作";
        }
    }
    
    return cell;
}



- (void)clickHeadButton:(id)sender{
    self.selectType = [sender tag];
}


-(void)backPaint{

    [self.navigationController  popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
