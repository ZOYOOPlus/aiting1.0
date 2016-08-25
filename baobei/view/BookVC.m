//
//  BookVC.m
//  baobei
//   
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "BookVC.h"
#import "BookCell.h"
#import "RecordingView.h"
#import "LearnVC.h"
#import "BookDao.h"

static NSString *celllD = @"HImageListCell";

@interface BookVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, assign) NSInteger selectType;
@property (nonatomic,strong )NSMutableArray *arrMBooks;
@property (nonatomic, strong) NSArray *photoArray;
@end

@implementation BookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精选图书";
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backNav)];
    self.navigationItem.leftBarButtonItems = @[backBtn];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor  whiteColor];
    //    [self setupBtn];
    //    [self setupImage];
    //    [self setupLabel];[self.view addSubview:self.collectionView];
    //  [self addHeadView];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]  initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
    
    self.navigationItem.rightBarButtonItem = shareBtn;
//    self.selectType = 1;
    [self getBookPhotoMessage];
  //  [self.collectionView reloadData];
}
- (void)shareClick{

}
- (void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

#pragma mark  请求图书

- (void)getBookPhotoMessage{

    [self showProgressView:nil];
    [BookDao getBookPhotoWithUserid:nil sucess:^(NSArray *list) {
        [self hidenProgress];
        self.photoArray = list;
        [self.collectionView reloadData];
    } fail:^{
        [self hidenProgress];
         [self showAlertView:@"提示" content:@"请求数据失败，请检查网络"];
    }];

}


- (void)backNav{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)setSelectType:(NSInteger)selectType{
//    if (_selectType == selectType) {
//        return;
//    }
//    _selectType = selectType;
//    [self.collectionView reloadData];
//}

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
        [_collectionView registerClass:[BookCell class] forCellWithReuseIdentifier:celllD];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}
#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 代理传值
    NSIndexPath * indexP = indexPath;
    self.delegate.bookIndexPath = indexP;
    

//    NSIndexPath *creat = [NSIndexPath indexPathForRow:0 length:0];
//    [collectionView scrollToItemAtIndexPath:creat atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    
   
    if (indexPath.row == 1){
        
        [self.navigationController  popViewControllerAnimated:YES];
////        [self.navigationController popToViewController: animated:<#(BOOL)#>]
//        RecordingView *RV = [[RecordingView alloc]init];
////        [self.navigationController popToViewController:RV animated:NO];
//        [self.navigationController pushViewController:RV animated:YES];
        [self.collectionView  reloadData];
       
    }else{
        
           [self.navigationController  popViewControllerAnimated:YES];
//        RecordingView *RV = [[RecordingView alloc]init];
//        [self.navigationController pushViewController:RV animated:YES];
        [self.collectionView  reloadData];
       
            }
}


-(void)backPaint2{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}

//-(void)imageQueryBooks{
//    AVQuery* query = [AVQuery queryWithClassName:@"SpeakPhoto"];
//    [query orderByAscending:@"order"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error==NULL && objects!= NULL && objects.count > 0) {
//            _arrMBooks = [NSMutableArray  arrayWithCapacity:42];
//            for (int i = 0; i < objects.count; i ++) {
//                AVFile* imageFile = [objects[i] objectForKey:@"Books"];
//                [_arrMBooks addObject:imageFile.url];
//                //  NSLog(@"%@",imageFile.url);
//            }
//        }
//    }];
//    [self.collectionView  reloadData];
//}
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celllD forIndexPath:indexPath];

     cell.bookPhotoModel = self.photoArray[indexPath.row];
        
    return cell;
}



//- (void)clickHeadButton:(id)sender{
//    self.selectType = [sender tag];
//}

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
