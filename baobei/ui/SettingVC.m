//
//  SettingVC.m
//  baobei
//
//  Created by 张源海 on 16/7/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "SettingVC.h"
#import "HCommon.h"
#import "ActionSheetStringPicker.h"
#import "AppDelegate.h"
#import "ResetVC.h"
@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate>


@property  (nonatomic, strong) NSTimer *timer;
@end

@implementation SettingVC
- (instancetype)init
{
    self = [super init];
    if (self) {
      self.tableViewStyle = UITableViewStylePlain;
      
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setExtraCellLineHidden:self.tableView];
 
}

-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];   
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
// 隐藏多余显示的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"清理缓存";
     
    }
    else if (indexPath.row == 1)
    {
      cell.textLabel.text = @"护眼模式";
    } else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"关于我们";
    }
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"修改密码";
    }
    else if (indexPath.row == 4)
    {
       
        cell.textLabel.text = @"退出登录";
    }
    return cell;
    
}
- (NSString*)cacthSize
{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    NSUInteger size = cache.diskCache.totalCount;
    NSLog(@">>>>%ld",size);
    NSUInteger Msize = size;
    NSString *stre = [NSString stringWithFormat:@"%ld",Msize];
    return stre;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        YYImageCache *cache = [YYWebImageManager sharedManager].cache;
        
        
        // 清空磁盘缓存，带进度回调
        [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
            // progress
        } endBlock:^(BOOL error) {
            // end
            //  [self showToast:@"清除缓存成功"];
        }];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NULL message:@"清理成功" delegate:NULL cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    }
    else if(indexPath.row == 1)
    {
         [self clickLock];
       

    }else if (indexPath.row == 3){
        
        
        ResetVC *RVC = [[ResetVC alloc]init];
        
        [self.navigationController pushViewController:RVC animated:YES];
        
        
    
    }else if (indexPath.row == 4){
    
       
    
        //退出设置
        [AVUser logOut];
        if ([AVUser currentUser] == NULL) {
            //          _UserName.text = @"请登录";
            //            _Userimager.image = [UIImage imageNamed:@"head.jpg"];
        }else{
            
            //        _UserName.text = [NSString stringWithFormat:@"@Dream%@",_LoginName];
            //[[AVUser  currentUser] username ];
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NULL message:@"退出登录成功！" delegate:NULL cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    
    }
    
    
}



-(void)clickLock{
    
    NSLog(@"锁住了");
    
    NSArray *timels = [NSArray arrayWithObjects:@"无限", @"60min", @"45min", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"护眼模式"
                                            rows:timels
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           // 选择以后做的事
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           
                                           // 不能使用睡眠模式
                                           //  [NSThread sleepForTimeInterval:3.0];
                                           
                                           
                                           if (selectedIndex ==0) {
                                               
                                               //
                                               //                                               _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(exitApp) userInfo:nil repeats:NO];
                                               
                                           }else if (selectedIndex == 1){
                                               
                                               _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(exitApp) userInfo:nil repeats:NO];
                                               
                                           }else{
                                               
                                               _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(exitApp) userInfo:nil repeats:NO];
                                               
                                           }
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         // 取消以后做的事
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
    
}


// 退出程序 动画
-(void)exitApp
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出本程序"  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        UIWindow *window = app.window;
        [UIView animateWithDuration:1.0f animations:^{
            window.alpha = 0.1;
            window.frame = CGRectMake(0, 0, window.bounds.size.height, 0);
        } completion:^(BOOL finished) {
            exit(0);
        }];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再玩会" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self.parentViewController presentViewController:alertController animated:YES completion:^{
        
    }];
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
