//
//  ResetVC.m
//  baobei
//
//  Created by 张源海 on 16/7/9.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ResetVC.h"

@interface ResetVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton     *nestButton;
//@property (nonatomic,strong) UIButton     *codeButton;
//@property (nonatomic,strong) UITextField *phoneTextField;
//@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UITextField *pwdTextField2;
@end

@implementation ResetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUp];
}
- (void)setUp{
    
    _nestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nestButton setBackgroundColor:[UIColor  orangeColor]];
    [_nestButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    [_nestButton addTarget:self action:@selector(clickRegistButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nestButton];
    
//    _codeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [_codeButton addTarget:self action:@selector(getCodeButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_codeButton];
//    
//    _phoneTextField = [[UITextField alloc] init];
//    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _phoneTextField.textColor = [UIColor blackColor];
//    _phoneTextField.delegate = self;
//    _phoneTextField.placeholder = @"📱请输入您的手机号";
//    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [self.view addSubview:_phoneTextField];
    
//    _codeTextField = [[UITextField alloc] init];
//    _codeTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _codeTextField.textColor = [UIColor blackColor];
//    _codeTextField.delegate = self;
//    _codeTextField.placeholder = @"㊙️请输入短信验证码";
//    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [self.view addSubview:_codeTextField];
//    
    
    [self.nestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-10);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view.mas_top).offset(160);
    }];
    
    
//    
//    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.equalTo(self.view.mas_width).offset(-10);
//        make.height.mas_equalTo(60);
//        make.top.equalTo(self.view.mas_top).offset(20);
//    }];
//    
//    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(5);
//        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(60);
//        make.size.mas_equalTo(CGSizeMake(200, 60));
//    }];
//    
//    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(220);
//        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(60);
//        make.size.mas_equalTo(CGSizeMake(100, 60));
//    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).offset(-10);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.view.mas_top).offset(280);
    }];
    
    //    [self.protile mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(self.view.mas_centerX);
    //        make.width.equalTo(self.view.mas_width).offset(-10);
    //        make.height.mas_equalTo(40);
    //        make.top.equalTo(self.view.mas_top).offset(420);
    //    }];
    //    [self.SinaLogin mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.WeiXinLogin.mas_right).offset(5);
    //        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    //        make.size.mas_equalTo(CGSizeMake(120, 120));
    //    }];
}
- (void)clickRegistButton:(id)sender{
    if (_pwdTextField.text.length <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"请填写手机号！" delegate:NULL
                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
        [alertView show];
    }else if(_pwdTextField2.text.length <= 0){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NULL message:@"验证码不能为空！" delegate:NULL
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
       // user.username = _phoneTextField.text;
        user.password = _pwdTextField.text;
       // user.mobilePhoneNumber = _phoneTextField.text;
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
//    if (_phoneTextField.text.length <= 0) {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:NULL message:@"请填写手机号" delegate:NULL
//                                  cancelButtonTitle:@"确定" otherButtonTitles:NULL];
//        [alertView show];
//    }else{
//        [AVOSCloud requestSmsCodeWithPhoneNumber:_phoneTextField.text callback:^(BOOL succeeded, NSError *error) {
//            // 发送失败可以查看 error 里面提供的信息
//            if (error==NULL && succeeded) {
//                [self checkCode];
//            }else{
//                UIAlertView *alertView = [[UIAlertView alloc]
//                                          initWithTitle:NULL message:@"获取验证码失败，请重新获取" delegate:NULL
//                                          cancelButtonTitle:@"确定" otherButtonTitles:NULL];
//                [alertView show];
//            }
//        }];
//        
//    }
//    
//}
//// MARK:  -----倒计时
//- (void)checkCode{
//    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                self.codeButton.enabled = true;
//                [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//            });
//        }else{
//            int seconds = timeout ;
//            NSString *strTime = [NSString stringWithFormat:@"%d秒后获取验证码", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                self.codeButton.enabled = false;
//                [_codeButton setTitle:strTime forState:UIControlStateNormal];
//            });
//            timeout--;
//            
//        }
//    });
//    dispatch_resume(_timer);
}
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_pwdTextField resignFirstResponder];
    [_pwdTextField2 resignFirstResponder];
 //   [_pwdTextField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"账号验证";
    //    self.tabBarController.title = @"用户注册";
}


@end
