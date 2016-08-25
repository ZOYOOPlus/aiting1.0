//
//  RegistVC.m
//  baobei
//
//  Created by wu on 16/6/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *registButton;
@property (nonatomic,strong) UIButton *codeButton;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UITextField *pwdTextField2;
@property (nonatomic,strong) UIView  *passLine;
@property (nonatomic,strong) UIView  *passLine2;
@property (nonatomic,strong) UIView  *passLine3;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *protile;
@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUp];
}
- (void)setUp{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5 - 50, 10, 100, 100)];
    
    [imageView setImage:[UIImage imageNamed:@"01.png"]];
    
    [self.view  addSubview:imageView];
    

    
    
    
    _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registButton setBackgroundColor:[UIColor  orangeColor]];
    [_registButton setTitle:@"注册" forState:(UIControlStateNormal)];
    _registButton.layer.borderWidth=1.0f;
    _registButton.layer.cornerRadius=15.0f;
    _registButton.layer.masksToBounds=YES;
    _registButton.layer.borderColor = [[UIColor  orangeColor]CGColor];
    [_registButton addTarget:self action:@selector(clickRegistButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registButton];
    
    
    
    
    
    _codeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [_codeButton addTarget:self action:@selector(getCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeButton];
    [_codeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _codeButton.layer.cornerRadius=10.0f;
    _codeButton.layer.masksToBounds=YES;
    _codeButton.layer.borderColor=[[UIColor orangeColor]CGColor];
    _codeButton.layer.borderWidth= 1.0f;
    if ([UIScreen mainScreen].bounds.size.width == 320) {
         _codeButton.frame = CGRectMake(210, 180, 85, 30);
    }else{
    
        _codeButton.frame = CGRectMake(250, 180, 85, 30);
    }
   
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.textColor = [UIColor blackColor];
    _phoneTextField.layer.cornerRadius=15.0f;
    _phoneTextField.layer.masksToBounds=YES;
    _phoneTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    _phoneTextField.layer.borderWidth= 1.0f;
    _phoneTextField.delegate = self;
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextField];
    
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _codeTextField.textColor = [UIColor blackColor];
     _codeTextField.clearButtonMode = UITextFieldViewModeAlways;
        _codeTextField.delegate = self;
        _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.secureTextEntry = true;
    _codeTextField.layer.cornerRadius=15.0f;
    _codeTextField.layer.masksToBounds=YES;
    _codeTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    _codeTextField.layer.borderWidth= 1.0f;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.view addSubview:_codeTextField];
    
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
       _pwdTextField.clearButtonMode = UITextFieldViewModeAlways;
    _pwdTextField.textColor = [UIColor blackColor];
    _pwdTextField.delegate = self;
    _pwdTextField.secureTextEntry = true;
     _pwdTextField.placeholder = @"请输入密码";
    _pwdTextField.layer.cornerRadius=15.0f;
    _pwdTextField.layer.masksToBounds=YES;
    _pwdTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    _pwdTextField.layer.borderWidth= 1.0f;
    [self.view addSubview:_pwdTextField];
    
#pragma mark // 我是华丽的分割线
    _passLine = [[UIView alloc]init];
    _passLine.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_passLine];
    _passLine2 = [[UIView alloc]init];
    _passLine2.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_passLine2];
    _passLine3 = [[UIView alloc]init];
    _passLine3.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_passLine3];
    
    _protile = [UIButton buttonWithType:UIButtonTypeCustom];
    [_protile setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_protile setTitle:@"● 同意注册协议" forState:UIControlStateNormal];
    _protile.backgroundColor = [UIColor whiteColor];
    

    [self.view addSubview:_protile];
    

    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-140);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(20);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(self.view.mas_width).offset(-40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.view.mas_top).offset(120);
    }];
    
    [self.passLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(self.view.mas_width).offset(0);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.view.mas_top).offset(120+2+40);
    }];
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        
        [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.top.equalTo(self.phoneTextField.mas_bottom).offset(20);
            make.size.mas_equalTo(CGSizeMake(180, 40));
        }];
        
    }else{
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(20);
         make.size.mas_equalTo(CGSizeMake(220, 40));
    }];
    }
    [self.passLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(self.view.mas_width).offset(0);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.view.mas_top).offset(120+42+40+20);
    }];
//    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(220);
//        make.top.equalTo(self.phoneTextField.mas_bottom).offset(20);
//        make.size.mas_equalTo(CGSizeMake(100, 40));
//    }];
//    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.equalTo(self.view.mas_width).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(self.view.mas_width).offset(-40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.codeTextField.mas_top).offset(60);
    }];
    
    [self.passLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(self.view.mas_width).offset(0);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.view.mas_top).offset(120+42+40+20+40+20);
    }];
    
    [self.protile mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.equalTo(self.view.mas_width).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(self.view.mas_width).offset(-40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.registButton.mas_bottom).offset(10);
    }];
      //    [self.SinaLogin mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.WeiXinLogin.mas_right).offset(5);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
//        make.size.mas_equalTo(CGSizeMake(120, 120));
//    }];
}
- (void)clickRegistButton:(id)sender{
    if (_phoneTextField.text.length <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"请填写手机号！" delegate:NULL
                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    }else if(_pwdTextField.text.length <= 0){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"密码不能为空！" delegate:NULL
                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    }else
    //if(_pwdTextField2.text != _pwdTextField.text){
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:NULL message:@"2次输入密码需要一致！" delegate:NULL
//                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
//        [alertView show];
//    }else
    {
        [self.view setUserInteractionEnabled:NO];
        AVUser *user = [AVUser user];
        user.username = _phoneTextField.text;
        user.password = _pwdTextField.text;
        user.mobilePhoneNumber = _phoneTextField.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error == NULL && succeeded) {
                [self.view setUserInteractionEnabled:YES];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self.view setUserInteractionEnabled:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NULL message:@"注册失败，请重新注册" delegate:NULL cancelButtonTitle:@"确定" otherButtonTitles:NULL];
                [alertView show];
            }
        }];
    }
    
}
- (void)getCodeButton:(id)sender{
        if (_phoneTextField.text.length <= 0) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:NULL message:@"请填写手机号" delegate:NULL
                                      cancelButtonTitle:@"确定" otherButtonTitles:NULL];
            [alertView show];
        }else{
            [AVOSCloud requestSmsCodeWithPhoneNumber:_phoneTextField.text callback:^(BOOL succeeded, NSError *error) {
                // 发送失败可以查看 error 里面提供的信息
                if (error==NULL && succeeded) {
                    [self checkCode];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:NULL message:@"获取验证码失败，请重新获取" delegate:NULL
                                              cancelButtonTitle:@"确定" otherButtonTitles:NULL];
                    [alertView show];
                }
            }];
    
        }
    
}
// MARK:  -----倒计时
- (void)checkCode{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.codeButton.enabled = true;
                [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout ;
            NSString *strTime = [NSString stringWithFormat:@"%d秒后获取验证码", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.codeButton.enabled = false;
                [_codeButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"注册";
     [_phoneTextField becomeFirstResponder];
    //    self.tabBarController.title = @"用户注册";
}


@end
