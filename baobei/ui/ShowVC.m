//
//  ShowVC.m
//  baobei
//
//  Created by 贺少虎 on 16/5/15.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShowVC.h"
#import "HImageListCell.h"
#import "ShowCell.h"
#import "PlayVC.h"
#import "ShowPhotoModel.h"
#import "HWebView.h"
#import "ShowDao.h"

static NSString *cellID = @"HImageListCell";

@interface ShowVC()<UICollectionViewDelegate,UICollectionViewDataSource>

@property  (nonatomic, strong)    UICollectionView *collectionView;
@property  (nonatomic, strong)    UIButton *Titlebutton;
@property  (nonatomic, assign)    NSInteger selectType;
@property  (nonatomic, strong)    NSArray *nameArry;
@property  (nonatomic, strong)    NSArray *photoArray;
@property  (nonatomic, strong)    NSArray  *zanArray;
@property  (nonatomic, strong)    NSArray  *SellArray;
@property  (nonatomic, strong)    HWebView *webView;

@end

@implementation ShowVC
-(HWebView *)webView
{
    if (!_webView) {
        _webView = [[HWebView alloc]init];
    }
    return _webView;
}
- (void)viewDidLoad{
    [super viewDidLoad];
   self.tabBarController.navigationItem.title = @"梦想秀场";
    [self addHeadView];
    
    UIButton *btn = [self.view viewWithTag:101];
    
    btn.selected = YES;
    
    self.selectType = 1;
    self.view.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.collectionView];
       [self getShowPhotoMessage];
}

- (void)getShowPhotoMessage {
    [self showProgressView:nil];
    [ShowDao getShowPhotoWithUserId:nil sucess:^(NSArray *list) {
        [self hidenProgress];
        self.photoArray = list;
        [self.collectionView reloadData];
    } fail:^{
        [self hidenProgress];
        [self showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   self.tabBarController.navigationItem.title = @"梦想秀场";
}

- (void)addHeadView{
    // 2ge button
    NSArray *titleArray = @[@"小能手",@"小主播"];
    NSArray *color = @[@"#BE92ED",@"#FF87B2"];
  //  NSArray *titleColor = @[@"#d2691e",@"#6495ed",];
    CGFloat margin = 10;
    CGFloat width = (self.view.frame.size.width - margin *3)/2;
    //    CGFloat barHeight = self.navigationController.navigationBar.bounds.size.height
    //    + [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat barHeight = 0;
    for (int index = 0; index < 2; index++) {
       UIButton  *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(margin+ (width + margin) * index, margin + barHeight , width, 40);
        [titleBtn setTitle:titleArray[index] forState:UIControlStateNormal];
        [titleBtn setBackgroundColor:[UIColor colorWithHexString:color[index]]];
        [titleBtn setTag:index + 1];
        
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        [titleBtn addTarget:self action:@selector(clickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
         titleBtn.layer.masksToBounds = YES;
        titleBtn.layer.cornerRadius = 6.0;
        titleBtn.tag = 101 + index;
        [self.view addSubview:titleBtn];
    }
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height - 66 ) collectionViewLayout:layout];
        [_collectionView registerClass:[ShowCell class] forCellWithReuseIdentifier:cellID];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    AVQuery* query = [AVQuery queryWithClassName:@"ShowWorks"];
    [query orderByAscending:@"order"];
    //[query orderByDescending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(![self.navigationController.childViewControllers.lastObject isKindOfClass:[HWebView class]]){
            NSString *SWURL = [objects[indexPath.row] objectForKey:@"SW_url"];
            if (SWURL == NULL){
                
                
            }else{
                HWebView *webView = [[HWebView alloc] initWithURLString:SWURL];
                [self.navigationController pushViewController:webView animated:YES];
            }
        }
    }];

}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count;
    switch (self.selectType) {
        case 1:
            return self.photoArray.count;
            return  self.nameArry.count;
            return self.zanArray.count;
            break;
        case 2:
            count = 16;
            break;
        case 3:
            count = 12;
        default:
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (self.selectType == 1) {

 
                cell.layer.borderWidth = 0.2;
                cell.layer.borderColor = [[UIColor orangeColor] CGColor];
        
        
        cell.imageView.image = [UIImage imageNamed:@"head"];
                cell.showPhotoMode = self.photoArray [indexPath.row];
                NSLog(@"%@",cell.showPhotoMode);
                cell.userName.text = self.nameArry[indexPath.row];
                NSLog(@"%@",cell.userName.text);
                cell.zan.text = self.zanArray[indexPath.row];
                NSLog(@"%@",cell.zan.text);
        
        
//     if (indexPath.row == 0){
//                cell.imageView.image = [UIImage imageNamed:@"baby1.jpg"];
//                cell.userName.text = @"海生";
//                cell.zan.text = @"178";
//            }
//            else if (indexPath.row == 1){
//                cell.imageView.image = [UIImage imageNamed:@"baby2.jpg"];
//                cell.userName.text = @"小秋";
//                    cell.zan.text = @"122";
//            }
//            else if (indexPath.row == 2){
//                cell.imageView.image = [UIImage imageNamed:@"baby3.jpg"];
//                cell.userName.text = @"腊梅";
//                    cell.zan.text = @"163";
//            }else if (indexPath.row == 3){
//                cell.imageView.image = [UIImage imageNamed:@"baby4.jpg"];
//                cell.userName.text = @"小虎";
//                    cell.zan.text = @"105";
//            }else if (indexPath.row == 4){
//                cell.imageView.image = [UIImage imageNamed:@"baby5.jpg"];
//                cell.userName.text = @"大龙";
//                    cell.zan.text = @"218";
//            }else if (indexPath.row == 5){
//            cell.imageView.image = [UIImage imageNamed:@"h22.jpg"];
//            cell.userName.text = @"阿娟";
//                cell.zan.text = @"178";
//        }else if (indexPath.row == 6){
//            cell.imageView.image = [UIImage imageNamed:@"h11.jpg"];
//            cell.userName.text = @"英子";
//                cell.zan.text = @"208";
//        }else if (indexPath.row == 7){
//            cell.imageView.image = [UIImage imageNamed:@"h12.jpg"];
//            cell.userName.text = @"明明";
//                cell.zan.text = @"181";
//        }
//        else if (indexPath.row == 8){
//            cell.imageView.image = [UIImage imageNamed:@"h14.jpg"];
//            cell.userName.text = @"小川";
//                cell.zan.text = @"101";
//        }
//        else if (indexPath.row == 9){
//            cell.imageView.image = [UIImage imageNamed:@"h18.jpg"];
//            cell.userName.text = @"晨晨";
//                cell.zan.text = @"128";
//        }
//        else if (indexPath.row == 10){
//            cell.imageView.image = [UIImage imageNamed:@"h19.jpg"];
//            cell.userName.text = @"小小";
//        }
//        else if (indexPath.row == 11){
//            cell.imageView.image = [UIImage imageNamed:@"h13.jpg"];
//            cell.userName.text = @"亮亮";
//                cell.zan.text = @"176";
//        }
//        else if (indexPath.row == 12){
//            cell.imageView.image = [UIImage imageNamed:@"h3.jpg"];
//            cell.userName.text = @"小霞";
//                cell.zan.text = @"181";
//        }
//        else if (indexPath.row == 13){
//            cell.imageView.image = [UIImage imageNamed:@"h16.jpg"];
//            cell.userName.text = @"津津";
//                cell.zan.text = @"141";
//        }
//        else if (indexPath.row == 14){
//            cell.imageView.image = [UIImage imageNamed:@"h15.jpg"];
//            cell.userName.text = @"宁宁";
//                cell.zan.text = @"143";
//        }   else if (indexPath.row == 15){
//            cell.imageView.image = [UIImage imageNamed:@"h7.jpg"];
//            cell.userName.text = @"晨晨";
//                cell.zan.text = @"228";
//        }
//        else if (indexPath.row == 16){
//            cell.imageView.image = [UIImage imageNamed:@"h17.jpg"];
//            cell.userName.text = @"小小";
//                cell.zan.text = @"306";
//        }
//        else if (indexPath.row == 17){
//            cell.imageView.image = [UIImage imageNamed:@"h8.jpg"];
//            cell.userName.text = @"亮亮";
//                cell.zan.text = @"172";
//        }
//        else if (indexPath.row == 18){
//            cell.imageView.image = [UIImage imageNamed:@"h10.jpg"];
//            cell.userName.text = @"小霞";
//                cell.zan.text = @"102";
//        }
//        else if (indexPath.row == 19){
//            cell.imageView.image = [UIImage imageNamed:@"h20.jpg"];
//            cell.userName.text = @"津津";
//                cell.zan.text = @"208";
//        }
    
        
    }else if (self.selectType == 2){
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"xiao_1.png"];
            cell.userName.text = @"胖胖";
        }else if(indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"xiao_2.png"];
            cell.userName.text = @"乐乐";
        }else if(indexPath.row == 3) {
            cell.imageView.image = [UIImage imageNamed:@"zhu.png"];
            cell.userName.text = @"龙龙";
        }
    else if(indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"h2.jpg"];
        cell.userName.text = @"龙龙";}
        
    else if (indexPath.row == 5){
        cell.imageView.image = [UIImage imageNamed:@"h6.jpg"];
        cell.userName.text = @"宁宁";
        cell.zan.text = @"143";
    }else if (indexPath.row == 6){
        cell.imageView.image = [UIImage imageNamed:@"h9.jpg"];
        cell.userName.text = @"亮亮";
        cell.zan.text = @"176";
    }else if (indexPath.row == 7) {
        cell.imageView.image = [UIImage imageNamed:@"Map03_0.jpg"];
        cell.userName.text = @"阿莲";
        cell.zan.text = @"183";
    }else if (indexPath.row == 8){
        cell.imageView.image = [UIImage imageNamed:@"hua03.jpg"];
        cell.userName.text = @"小兰";
        cell.zan.text = @"162";
    } else if (indexPath.row == 9){
        cell.imageView.image = [UIImage imageNamed:@"hua04.jpg"];
        cell.userName.text = @"大勇";
        cell.zan.text = @"108";}

        else{
            cell.imageView.image = [UIImage imageNamed:@"qian.jpg"];
            cell.userName.text = @"钱钱";
                }
    }
    else{
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"long.jpg"];
            cell.userName.text = @"婷婷";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"update2/shougong2.jpg"];
            cell.userName.text = @"丽丽";
        }else if (indexPath.row == 2){
            cell.userName.text = @"沛沛";
            cell.imageView.image = [UIImage imageNamed:@"update2/shougong.jpg"];
        }else if (indexPath.row == 3){
            cell.imageView.image = [UIImage imageNamed:@"2.jpg"];
            cell.userName.text = @"大伟";
        }else if (indexPath.row == 4){
            cell.imageView.image = [UIImage imageNamed:@"3.jpg"];
            cell.userName.text = @"小杰";
        }else if (indexPath.row == 5){
            cell.imageView.image = [UIImage imageNamed:@"4.jpg"];
            cell.userName.text = @"南南";
        }else if (indexPath.row == 6){
            cell.imageView.image = [UIImage imageNamed:@"5.jpg"];
            cell.userName.text = @"小荣";
        }else if (indexPath.row == 7){
            cell.imageView.image = [UIImage imageNamed:@"6.jpg"];
            cell.userName.text = @"豆豆";
        }else if (indexPath.row == 8){
            cell.imageView.image = [UIImage imageNamed:@"7.jpg"];
            cell.userName.text = @"晶晶";
        }else if (indexPath.row == 9){
            cell.imageView.image = [UIImage imageNamed:@"8.jpg"];
            cell.userName.text = @"杜鹃";
        }else if (indexPath.row == 10){
            cell.imageView.image = [UIImage imageNamed:@"9.jpg"];
            cell.userName.text = @"大鹏";
        }else if (indexPath.row == 11){
            cell.imageView.image = [UIImage imageNamed:@"10.jpg"];
            cell.userName.text = @"小蕊";
        }
        
    }
    return cell;
}



- (void)clickHeadButton:(UIButton *)sender{
    
    
    if (sender.tag == 101) {
        
        sender.selected = YES;
        
        UIButton *btn = [self.view viewWithTag:102];
        
        btn.selected = NO;
        
    }else{
        sender.selected = YES;
        
        UIButton *btn = [self.view viewWithTag:101];
        
        btn.selected = NO;
        
    }
    

        self.selectType = sender.tag - 100 ;
}

@end
