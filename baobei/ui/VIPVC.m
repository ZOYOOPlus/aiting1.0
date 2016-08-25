//
//  VIPVC.m
//  baobei
//
//  Created by 张源海 on 16/7/28.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "VIPVC.h"
#import "HCommon.h"
#import "ActionSheetStringPicker.h"
#import "AppDelegate.h"
@interface VIPVC ()<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property  (nonatomic, strong) NSTimer *timer;

@end

@implementation VIPVC



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewCellStyleValue2;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExtraCellLineHidden:self.tableView];
     self.title = @"做任务得@币";
    [self setupUI];
}

-(void)setupUI{


}


// 隐藏多余显示的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
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

#pragma mark  --- 设置table行数 
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    cell.detailTextLabel.text=@"100";
//    [cell.detailTextLabel setTextColor:[UIColor orangeColor]];

    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"monalisa";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.detailTextLabel.text = @"mona";
    if (indexPath.row == 0)
    {
      
        cell.textLabel.text = @"亲友团";
        // 设置cell 的颜色
      //  [cell.textLabel setTextColor:[UIColor orangeColor]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150, 0, 100, 60)];
        label.text = @"+100";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
        //cell.detailTextLabel.text=@"+100                   ";
       // [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"分享朋友圈";
//        cell.detailTextLabel.text=@"+100                   ";
//        [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150, 60, 100, 60)];
        label.text = @"+100";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"参加活动";
//        cell.detailTextLabel.text=@"+100                   ";
//        [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150, 120, 100, 60)];
        label.text = @"+100";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
    }

    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"评价我们";
//        cell.detailTextLabel.text=@"+100                   ";
//        [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150, 180, 100, 60)];
        label.text = @"+100";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
    }
    else if (indexPath.row == 4)
    {
        cell.textLabel.text = @"建议";
//        cell.detailTextLabel.text=@"+100                   ";
//        [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150, 240, 100, 60)];
        label.text = @"+100";
        label.textColor = [UIColor orangeColor];
        [self.tableView addSubview:label];
    }

    return cell;
    
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
