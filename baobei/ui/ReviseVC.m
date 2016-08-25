//
//  ReviseVC.m
//  baobei
//
//  Created by 张源海 on 16/7/30.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ReviseVC.h"
#import "ResetVC.h"
#import "ActionSheetStringPicker.h"
#import "YHAddressManager.h"
#import "YHProvincialCitiesCountiesPickerview.h"
#import "AVUserd.h"

@interface ReviseVC ()<UIActionSheetDelegate,UIPickerViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
        CGRect orginFrame;
        UIImage *editedImage;
        NSString *_imageUrl;
    

}
@property (nonatomic,strong)NSMutableArray *groups;

@property (nonatomic,strong)YHProvincialCitiesCountiesPickerview *regionPickerView;

@property (nonatomic,strong)NSMutableArray *arrM;

@property  (nonatomic,strong) UIImageView *login;

@end

@implementation ReviseVC

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
    self.title = @"个人信息";
    self.navigationItem.rightBarButtonItem.title = @"保存";

    self.groups = [NSMutableArray array];
    [self  setExtraCellLineHidden:self.tableView];

    self.view.backgroundColor = [UIColor  colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    [self setupUI];
   // [self jiequ];
    [self registerKeyBoard];
  //   添加 更新资料  item
    UIBarButtonItem *item = [[UIBarButtonItem alloc]  initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(SaveUserinfo)];
    self.navigationItem.rightBarButtonItem = item;
    
    orginFrame = self.tableView.frame;
    
    
  
    
}



- (void)setupUI{
    
    //UI点击手势识别
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    tap.delegate=self;
//    [self.tableView addGestureRecognizer:tap];
    if([UIScreen mainScreen].bounds.size.width == 320){
        
        // 头像
        AVFile* imageFile = [[AVUser currentUser]objectForKey:@"userphoto"];
        
        NSURL *url2 = [NSURL URLWithString:imageFile.url];
        
        _login = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-200, 15, 70, 70)];
        _login.userInteractionEnabled = YES;
        _login.layer.masksToBounds = YES; //没这句话它圆不起来
        _login.layer.cornerRadius = 35.0; //设置图片圆角的尺度
        [_login sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"01"]];
//        _login.layer.masksToBounds = YES; //没这句话它圆不起来
//        _login.layer.cornerRadius = 35.0; //设置图片圆角的尺度
  //      _login.image = editedImage;

        [self.tableView addSubview:_login];
        
        _UserdName = [[UITextField alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 106, 260, 40)];
        [self.tableView addSubview:_UserdName];
        
        _UserdAge = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 106+48, 110, 40)];
        [self.tableView addSubview: _UserdAge];
        
        _UserdPhone = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 106+80+20, 110, 40)];
        [self.tableView addSubview:_UserdPhone];
        _UserdPhone.text = [NSString stringWithFormat:@"%@****%@",[[AVUser  currentUser].mobilePhoneNumber substringWithRange:NSMakeRange(0, 3)],[[AVUser  currentUser].username substringWithRange:NSMakeRange(7,4)]];
        
        _UserdCName = [[UITextField alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 320, 190, 40)];
        [self.tableView addSubview:_UserdCName];
        
        
        _UserdCName.text = [[AVUser currentUser]objectForKey:@"chirdenname"];
        //    _UserdCName.textAlignment = UITextAlignmentRight;
        NSLog(@"%@",_UserdCName.text);
        
        _UserdSex = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 320+48, 110, 40)];
        [self.tableView addSubview:_UserdSex];
        _UserdSex.text = [[AVUser currentUser]objectForKey:@"sex"];
        NSLog(@"%@",_UserdSex.text);
        
        _UserdBrithday = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 320+48*2, 110-5, 40)];
        
        
        [self.tableView addSubview:_UserdBrithday];
        _UserdBrithday.text = [[AVUser currentUser]objectForKey:@"birthday"];
        
        _UserdAddress = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 206+50, 200, 40)];
        [self.tableView addSubview:_UserdAddress];
        _UserdAddress.text = [[AVUser currentUser]objectForKey:@"address"];;
        //_UserdAddress.textAlignment = UITextAlignmentRight;

    }else{
        // 头像
        AVFile* imageFile = [[AVUser currentUser]objectForKey:@"userphoto"];
        NSURL *url2 = [NSURL URLWithString:imageFile.url];
        
        _login = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-200, 15, 70, 70)];
        _login.userInteractionEnabled = YES;
        _login.layer.masksToBounds = YES; //没这句话它圆不起来
        _login.layer.cornerRadius = 35.0; //设置图片圆角的尺度
        [_login sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"01"]];
        
        [self.tableView addSubview:_login];

        _UserdName = [[UITextField alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100-5, 260, 40)];
        [self.tableView addSubview:_UserdName];

        _UserdAge = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100+60-5+50-50-10, 110, 40)];
        [self.tableView addSubview: _UserdAge];

    _UserdPhone = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100+60-5+50, 110, 40)];
    [self.tableView addSubview:_UserdPhone];
     _UserdPhone.text = [NSString stringWithFormat:@"%@****%@",[[AVUser  currentUser].mobilePhoneNumber substringWithRange:NSMakeRange(0, 3)],[[AVUser  currentUser].username substringWithRange:NSMakeRange(7,4)]];
        
    _UserdCName = [[UITextField alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100+60+60+15+60-5+50+30+20+10-60+5, 190, 40)];
    [self.tableView addSubview:_UserdCName];
        

        _UserdCName.text = [[AVUser currentUser]objectForKey:@"chirdenname"];
    //    _UserdCName.textAlignment = UITextAlignmentRight;
         NSLog(@"%@",_UserdCName.text);
    
    _UserdSex = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100+60+60+15+60-5+50+30+20+10, 110, 40)];
    [self.tableView addSubview:_UserdSex];
    _UserdSex.text = [[AVUser currentUser]objectForKey:@"sex"];
        NSLog(@"%@",_UserdSex.text);
    
    _UserdBrithday = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100+60+60+15+60+60+60+30+10, 110-5, 40)];
    [self.tableView addSubview:_UserdBrithday];
     _UserdBrithday.text = [[AVUser currentUser]objectForKey:@"birthday"];
    
    _UserdAddress = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-200, 15+100+60+60+15+60+60+60-5-100-50, 200, 40)];
    [self.tableView addSubview:_UserdAddress];
        _UserdAddress.text = [[AVUser currentUser]objectForKey:@"address"];;
        //_UserdAddress.textAlignment = UITextAlignmentRight;
}
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIScreen mainScreen].bounds.size.width == 320){
    
        if (indexPath.section == 0 && indexPath.row == 0){
            
            return 100;
            
        }else if
            ( indexPath.section == 0 &&indexPath.row == 5){
                
                return 12;
                
            }
        else{
            
            return 50;
        }
    
    
    }else{
     if (indexPath.section == 0 && indexPath.row == 0){
        
    return 100;
        
    }else if
        ( indexPath.section == 0 &&indexPath.row == 5){
            
            return 30;
            
        }
     else{
        
        return 55;
    }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else{
    return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 2;
//      return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell"];
    
  
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"monalisa";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = @"mona";
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"头像";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if(indexPath.section == 0 && indexPath.row == 1){
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"家长昵称：";

        
        _UserdName.text = [[AVUser currentUser]objectForKey:@"name"];
    
    }else if(indexPath.section == 0 && indexPath.row == 2){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"家长年龄：";
        
            _UserdAge.text = [[AVUser currentUser]objectForKey:@"Personage"];
 
    }
    else if(indexPath.section == 0 && indexPath.row == 3){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"手机号：";
        
    }
    
    
    else if(indexPath.section == 0 && indexPath.row == 4){
        
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"签收地址：";
        // 分组 改换值
    } else if(indexPath.section == 0 && indexPath.row == 5){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = nil;
           cell.backgroundColor = [UIColor  colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        // 去掉右边的箭头
         [cell setAccessoryType:UITableViewCellAccessoryNone];

        
//    }
//    else if (indexPath.section == 1 && indexPath.row == 3){
//    
//    
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"我的地址：";
  
        
    
        }else if (indexPath.section == 1 && indexPath.row == 0){
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"孩子姓名：";

        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"孩子性别：";

    }else if (indexPath.section == 1 && indexPath.row == 2){
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"formCell"];        cell.textLabel.text = @"孩子年龄：";
      
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.UserdCName resignFirstResponder];
    [self.UserdName resignFirstResponder];
    [self.UserdAddress resignFirstResponder];
    if (indexPath.section == 0 && indexPath.row == 0){
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
        [actionSheet showInView:self.view];
        
    
    }else if (indexPath.section == 0 && indexPath.row == 2){
    
    
        // 自定义弹出框 KVC
        UIAlertController *alert2= [UIAlertController alertControllerWithTitle:@"年龄段" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"请选择年龄段"];
        
        [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, [[hogan string] length])];
        
        [alert2 setValue:hogan forKey:@"attributedTitle"];
        
        //分别按顺序放入每个按钮；
        [alert2 addAction:[UIAlertAction actionWithTitle:@"70后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            
            _UserdAge.text= @"70后";
            
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"75后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdAge.text =  @"75后";
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"80后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdAge.text =  @"80后";
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"85后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdAge.text =  @"85后";
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"90后" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdAge.text =  @"90后";
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            NSLog(@"点击了取消");
        }]];
        
        if ([_UserdAge.text  isEqual: @"70后"]){
            UIAlertAction * a =  alert2.actions[0];
            
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
        }if ([_UserdAge.text  isEqual: @"75后"]){
            UIAlertAction * a =  alert2.actions[1];
            
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
        }if ([_UserdAge.text  isEqual: @"80后"]){
            
            UIAlertAction * a =  alert2.actions[2];
            
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
        }if ([_UserdAge.text  isEqual: @"85后"]){
            
            UIAlertAction * a =  alert2.actions[3];
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
        }if ([_UserdAge.text  isEqual: @"90后"]){
            
            UIAlertAction * a =  alert2.actions[4];
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
        }
        
        NSLog(@"%@",alert2.textFields);
        //弹出提示框；
        [self presentViewController:alert2 animated:true completion:nil];
        

    }
    
    
    else if (indexPath.section == 1 && indexPath.row == 1){
    

        
        // 自定义弹出框 KVC
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"性别选择" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"请选择性别"];
        
        [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, [[hogan string] length])];
        
        [alert1 setValue:hogan forKey:@"attributedTitle"];
        
        [alert1 addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdSex.text =  @"男";
        }]];
        
        [alert1 addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdSex.text =  @"女";
        }]];
        
        if ([_UserdSex.text  isEqual: @"男"]){
            UIAlertAction * a1 =  alert1.actions[0];
            
            [a1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
        }if ([_UserdSex.text  isEqual: @"女"]){
            UIAlertAction * a1 =  alert1.actions[1];
            
            [a1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
        }
        
        
        //弹出提示框；
        [self presentViewController:alert1  animated:true completion:nil];
    
    }else if(indexPath.section == 1 && indexPath.row == 2){
 
        
        // 自定义弹出框 KVC
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"年龄选择" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"请选择年龄"];
        
        [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, [[hogan string] length])];
        
        [alert setValue:hogan forKey:@"attributedTitle"];
        
        //分别按顺序放入每个按钮；
        [alert addAction:[UIAlertAction actionWithTitle:@"0~2岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            
            _UserdBrithday.text= @"0~2岁";
            
        }]];
     
        [alert addAction:[UIAlertAction actionWithTitle:@"3~6岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdBrithday.text =  @"3~6岁";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"7~9岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdBrithday.text =  @"7~9岁";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"10~12岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdBrithday.text =  @"10~12岁";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"13岁+" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            _UserdBrithday.text =  @"13岁+";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            NSLog(@"点击了取消");
        }]];
        
        if ([_UserdBrithday.text  isEqual: @"0~2岁"]){
            UIAlertAction * a =  alert.actions[0];
            
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
        }if ([_UserdBrithday.text  isEqual: @"3~6岁"]){
            UIAlertAction * a =  alert.actions[1];
            
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
        
        }if ([_UserdBrithday.text  isEqual: @"7~9岁"]){
        
            UIAlertAction * a =  alert.actions[2];
            
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
        }if ([_UserdBrithday.text  isEqual: @"10~12岁"]){
        
            UIAlertAction * a =  alert.actions[3];
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
        
        }if ([_UserdBrithday.text  isEqual: @"13岁+"]){
            
            UIAlertAction * a =  alert.actions[4];
            [a setValue:[UIColor redColor] forKey:@"titleTextColor"];
            
        }
        
      
 
        NSLog(@"%@",alert.textFields);
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    
    }else if(indexPath.section == 0 && indexPath.row == 4){
        
        
        [self show];
    }
    

}


- (void)show{
    NSString *address = _UserdAddress.text;
    NSArray *array = [address componentsSeparatedByString:@" "];
    
    NSString *province = @"";//省
    NSString *city = @"";//市
    NSString *county = @"";//县
    if (array.count > 2) {
        province = array[0];
        city = array[1];
        county = array[2];
    } else if (array.count > 1) {
        province = array[0];
        city = array[1];
    } else if (array.count > 0) {
        province = array[0];
    }
    
    [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];
}

- (YHProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[YHProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
            __strong typeof(wself) self = wself;
            self.UserdAddress.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}


#pragma mark UIActionSheetDelegate M
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    
    if (buttonIndex == 0) {
        //        拍照
        if (![self checkCameraAuthorizationStatus]) {
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        //        相册
        if (![self checkCameraAuthorizationStatus]) {
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *originalImage;
        editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        __weak typeof(self) weakSelf = self;
        NSData *data;
        if (UIImagePNGRepresentation(editedImage) == nil) {
            
            data = UIImageJPEGRepresentation(editedImage, 1);
//                        _login.layer.masksToBounds = YES; //没这句话它圆不起来
//                        _login.layer.cornerRadius = 35.0; //设置图片圆角的尺度
//                        _login.image = editedImage;
//            AVFile *file = [AVFile  fileWithData:UIImageJPEGRepresentation(editedImage, 0.5)];
//            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                NSLog(@"%@",error);
//                _login.image =editedImage;
//                 [self.tableView reloadData];
//            
//            }];
//            AVUser *user = [AVUser currentUser];
//            [user setObject:file forKey:@"userphoto"];
//                [self.tableView reloadData];
            
        } else {
            

            
            data = UIImagePNGRepresentation(editedImage);
                        _login.layer.masksToBounds = YES; //没这句话它圆不起来
                        _login.layer.cornerRadius = 35.0; //设置图片圆角的尺度
                     //   data = UIImagePNGRepresentation(editedImage);
                        _login.image = editedImage;
            AVFile *file = [AVFile  fileWithData:UIImageJPEGRepresentation(editedImage, 0.5)];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"%@",error);
            }];
            AVUser *user = [AVUser currentUser];
            [user setObject:file forKey:@"userphoto"];
            
            [self.tableView reloadData];
            
        }

        
        // 保存原图片到相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(originalImage, self, nil, NULL);
//            _login.image = originalImage;
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)checkCameraAuthorizationStatus
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不支持拍照"  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        
        [alertController addAction:sureAction];
   //     [alertController addAction:cancelAction];
        [self.parentViewController presentViewController:alertController animated:YES completion:^{
            
        }];
     //   NSLog(@"该设备不支持拍照");
        return NO;
    }
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];

            [alertController addAction:sureAction];
          
            [self.parentViewController presentViewController:alertController animated:YES completion:^{
                
            }];

            return NO;
        }
    }
    
    return YES;
}


// 隐藏多余显示的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


// 设置cell 的线 重屏幕最左侧开始
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

-(void)SaveUserinfo{

    
    AVFile *file = [AVFile  fileWithData:UIImageJPEGRepresentation(editedImage, 0.5)];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%@",error);
    }];
        AVUser *user = [AVUser currentUser];
        [user setObject:file forKey:@"userphoto"];
        [user setObject:_UserdName.text forKey:@"name"];
        [user setObject:_UserdSex.text forKey:@"sex"];
        [user setObject:_UserdAddress.text forKey:@"address"];
        [user setObject:_UserdCName.text forKey:@"chirdenname"];
        [user setObject:_UserdBrithday.text forKey:@"birthday"];
        [user setObject:_UserdAge.text forKey:@"Personage"];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"%@",user);
            NSLog(@"%@",error);
            [self.tableView reloadData];
        }];
    
    
    [self.tableView reloadData];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存信息"  preferredStyle:UIAlertControllerStyleAlert];
    
    /*title*/
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
    [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alertController setValue:alertTitleStr forKey:@"attributedTitle"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
       [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
 
    [self.parentViewController presentViewController:alertController animated:YES completion:^{
        
    }];
    

}



- (void)tapAction:(UITapGestureRecognizer *)tap{
       [self.UserdName resignFirstResponder];
       [self.UserdCName resignFirstResponder];
       [self.UserdAddress resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{

    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - keyBoardNotification
- (void)registerKeyBoard{
    //注册键盘弹起的通知中心  UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyBoardShow:(NSNotification *)no{
    NSDictionary *info = no.userInfo;
    //NSValue
    id objFrame = info[@"UIKeyboardFrameEndUserInfoKey"];
    
    CGRect keyBoardFrame = {0};
    //获取键盘的高度
    [objFrame getValue:&keyBoardFrame];
    
    //判断键盘能否把控件遮挡住
    CGRect tempFrame = self.tableView.frame;
    
    
    tempFrame.origin.y = [[UIScreen mainScreen] bounds].size.height- keyBoardFrame.size.height- tempFrame.size.height;
    self.tableView.frame = tempFrame;
    
}
- (void)keyBoardHidden:(NSNotification *)no{
    //当键盘隐藏的时候 把frame还原
    self.tableView.frame  = orginFrame;
}
//- (void)dealloc{
//    //注销通知中心
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}

// tableView 和 事件的冲突
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
//        //做自己想做的事
//        return NO;
//    }
//    return YES;
//    
//}

 @end
