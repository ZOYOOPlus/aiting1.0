//
//  LoginVC.m
//  baobei
//
//  Created by wu on 16/6/22.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"
#import "RemberVC.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registButton;

@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *pwdTextField;

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *forgetButton;
@property (nonatomic,strong) UIButton  *giftButton;

@property (nonatomic,strong)UIButton  *QQLogin;
@property (nonatomic,strong)UIButton  *WeiXinLogin;
@property (nonatomic,strong)UIButton  *SinaLogin;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    
    [self setUp];
}
- (void)setUp{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.4, 10, 100, 100)];
    
    [imageView setImage:[UIImage imageNamed:@"yazi.png"]];
    
    [self.view  addSubview:imageView];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _loginButton.backgroundColor = [UIColor colorWithRed:134.0/255.0 green:181.0/255.0 blue:247.0/255.0 alpha:1.0];
   // _loginButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录6_06"]];

    //[_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton  setBackgroundImage:[UIImage imageNamed:@"登录6_06.png"] forState:UIControlStateNormal] ;
    [_loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];

    //_forgetButton.backgroundColor = [UIColor orangeColor];
    [_forgetButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
   [_forgetButton addTarget:self action:@selector(clickRemberButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetButton];
    
    _giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
      //  _giftButton.backgroundColor = [UIColor orangeColor];
    [_giftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_giftButton setTitle:@"注册有礼" forState:UIControlStateNormal];
    [_giftButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.giftButton];
    
    
    
    _QQLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_QQLogin  setBackgroundImage:[UIImage imageNamed:@"登录_03.png"] forState:UIControlStateNormal] ;
    
    [self.view addSubview:self.QQLogin];
    
    _WeiXinLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    
     [_WeiXinLogin  setBackgroundImage:[UIImage imageNamed:@"登录_05.png"] forState:UIControlStateNormal] ;
    [self.view addSubview:self.WeiXinLogin];
    
    _SinaLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    
     [_SinaLogin  setBackgroundImage:[UIImage imageNamed:@"登录_07.png"] forState:UIControlStateNormal] ;
    
    [self.view addSubview:self.SinaLogin];
    

    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.textColor = [UIColor blackColor];
    _phoneTextField.delegate = self;
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextField];
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    _pwdTextField.textColor = [UIColor blackColor];
    _pwdTextField.delegate = self;
    _pwdTextField.placeholder = @"请输入密码";
    _pwdTextField.secureTextEntry = true;
    [self.view addSubview:_pwdTextField];
    
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(self.view.mas_top).offset(360);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    [self.giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(self.view.mas_top).offset(360);
         make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    
    [self.QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.WeiXinLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QQLogin.mas_right).offset(60);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.SinaLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).offset(-95);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-10);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view.mas_top).offset(300);
    }];

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-10);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view.mas_top).offset(120);
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-10);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view.mas_top).offset(210);
    }];
}
- (void)clickLogin:(id)sender{
    
    RegistVC *RVC = [[RegistVC alloc]init];
    
     [self.navigationController pushViewController:RVC animated:YES];
}

- (void)clickRemberButton:(id)sender{
    RemberVC *RemVC = [[RemberVC alloc]init];
    [self.navigationController pushViewController:RemVC animated:YES];
}
- (void)clickLoginButton:(id)sender{
    if (_phoneTextField.text.length <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"请填写手机号" delegate:NULL
                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    }else if(_pwdTextField.text.length <= 0){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"密码不能为空" delegate:NULL
                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    }else{
        [self.view setUserInteractionEnabled:NO];
        [AVUser logInWithMobilePhoneNumberInBackground:_phoneTextField.text password:_pwdTextField.text block:^(AVUser *user, NSError *error) {
            if (error == NULL && user != NULL) {
                [self.view setUserInteractionEnabled:YES];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self.view setUserInteractionEnabled:YES];
                NSLog(@"error==%@",error);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NULL message:@"登录失败，请重新登录" delegate:NULL cancelButtonTitle:@"确定" otherButtonTitles:NULL];
                [alertView show];
            }
        }];
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phoneTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_phoneTextField becomeFirstResponder];
}

@end
