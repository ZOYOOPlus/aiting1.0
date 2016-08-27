//
//  TYAdViewController.m
//  高仿网易新闻
//
//  Created by 张源海 on 15/12/28.
//  Copyright © 2015年 张源海. All rights reserved.
//

#import "TYAdViewController.h"
#import "UIView+BDExtension.h"
#import "LearnVC.h"
#import "HTabBarController.h"
#import "HNavigationController.h"
#import "HWebView.h"

#import "HCameraVC.h"

@interface TYAdViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSString *ADURL;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIImageView *Imageview;

@property (strong,nonatomic)NSTimer *timer;

@end

@implementation TYAdViewController
//    	1> 创建一个背景图片框,设置界面背景图片,全屏显示.
//    	2> 再创建一个广告图片框,设置一个固定尺寸的frame.
//    	3> GCD 延迟, 2秒广告结束后,获取主窗口,将主窗口的根控制器//更改为mainVc

//- (HWebView *)webView{
//    
//    if (!_webView) {
//        _webView = [[HWebView alloc]init];
//    }
//    return _webView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    _Imageview= [[UIImageView  alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
        _Imageview.userInteractionEnabled = YES;

      UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UesrClicked)];
    
    [_Imageview addGestureRecognizer:singleTap];
       [self.view addSubview:_Imageview];
    
    _Imageview.tag = 2;
    
        //这一步是获取上次网络请求下来的图片，如果存在就展示该图片，如果不存在就展示本地保存的名为test的图片
        NSMutableData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageu"];
        if (data.length>0) {
            _Imageview.image = [UIImage imageWithData:data];
        }else{
    
            _Imageview.image = [UIImage imageNamed:@"028"];
        }

        //下面这段代码，是调用AFN下载文件的方法，异步
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
// 请求是个block  所以要把下载线程放在 同一个网络进程里  否则获取不到 广告的URL  因为下载是异步
    AVQuery* query = [AVQuery queryWithClassName:@"ADguanggao"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==NULL && objects!= NULL && objects.count > 0) {
            AVFile *file = [objects[0] objectForKey:@"AD"];
            self.ADURL = file.url?file.url:@"";
            NSLog(@"广告的url%@",self.ADURL);
            
            // 图片赋值
//            [self.Imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.ADURL]] placeholderImage:[UIImage imageNamed:@"01"]];
            
            NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.ADURL]];
            NSLog(@"加载下载的%@",URL);
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                
                NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                NSLog(@"File downloaded to: %@", filePath);
                
                NSData * image = [NSData dataWithContentsOfURL:filePath];
                [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"imageu"];
                
                
            }];
            [downloadTask resume];

        }
    }];
    

    
    
    

    

//    adImageView.centerX = self.view.width * 0.5;
//    adImageView.centerY = self.view.height * 0.7;

    
//    
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//          
//          HTabBarController *tab = [[HTabBarController alloc] init];
//          HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
//          window.rootViewController = nv;
//    
//          
//      });
    
    
  //  [self UserNOClick];
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(UserNOClick) userInfo:nil repeats:NO];
    
}

- (void)UserNOClick{
    
//                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
                self.window = [UIApplication sharedApplication].keyWindow;
      
                                  self.window = [UIApplication sharedApplication].keyWindow;
                                  HTabBarController *tab = [[HTabBarController alloc] init];
                                  HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
//                                  [UIView animateWithDuration:0.5 animations:^{
//                                      _Imageview.alpha = 0.3;
//                                  } completion:^(BOOL finished) {
//                                      [UIView animateWithDuration:0.5
//                                                       animations:^(void) {
//                                                        self.window.rootViewController = nv;}
//                                       ];
//                                  }];
    [UIView animateWithDuration:0.5f animations:^{
        self.view.transform = (CGAffineTransformMakeScale(2.0, 1.0));
        self.view.backgroundColor = [UIColor clearColor];
        self.view.alpha = 0.0; //让scrollview 渐变消失
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.01
                                                                animations:^(void) {
                                                                 self.window.rootViewController = nv;}
                                                ];
    } ];
//                  });
    
    
        
            
            
        //        self.window.rootViewController = nv;
       // root  闪屏 处理
            
            
//            [UIView transitionFromView:self.window.rootViewController.view
//                                toView:self.view
//                              duration:1.0
//                               options:UIViewAnimationOptionTransitionCurlUp
//                            completion:^(BOOL finished)
//            {
//                self.window.rootViewController = nv;
//            }];
        
        
//            [UIView animateWithDuration:1 animations:^{
//                self.window.rootViewController.view.alpha = 0.7;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:2.0
//                                 animations:^(void) {nv.view.alpha = 1;}
//                 ];
//            }];
            
           
         NSLog(@"%@",self.window);
    
}



- (void)addBanner{
    AVQuery* query = [AVQuery queryWithClassName:@"ADguanggao"];
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==NULL && objects!= NULL && objects.count > 0) {
            AVFile *file = [objects[0] objectForKey:@"AD"];
            self.ADURL = file.url?file.url:@"";
            // 图片赋值
            [self.Imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.ADURL]] placeholderImage:[UIImage imageNamed:@"01"]];
        }
    }];
}
//[UIView animateWithDuration:0.7 animations:^{
//    self.window.rootViewController.view.alpha = 1.0;
//} completion:^(BOOL finished) {
//    [addSubview:splashImageView removeFromSuperview];
//}];
- (void)UesrClicked{

        [self.timer invalidate];
    
        // 点击多次广告业   只响应最后一次
        AVQuery* query = [AVQuery queryWithClassName:@"ADguanggao"];
        [query orderByAscending:@"order"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (![self.navigationController.childViewControllers.lastObject isKindOfClass:[HWebView class]]) {
                NSString *bannerurl = [objects[0] objectForKey:@"AD_url"];
                
                HWebView *webView = [[HWebView alloc] initWithURLString:bannerurl];
                self.window = [UIApplication sharedApplication].keyWindow;
                HTabBarController *tab = [[HTabBarController alloc] init];
                HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
                self.window.rootViewController = nv;
                NSLog(@"%@",self.window);
                
                [nv pushViewController:webView animated:YES];
                
                NSLog(@"点击了广告%@",bannerurl);
                
            }
            
        }];
    
    
    }
    
//    // 点击多次广告业   只响应最后一次
//    AVQuery* query = [AVQuery queryWithClassName:@"ADguanggao"];
//    [query orderByAscending:@"order"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (![self.navigationController.childViewControllers.lastObject isKindOfClass:[HWebView class]]) {
//            NSString *bannerurl = [objects[0] objectForKey:@"AD_url"];
//            
//            HWebView *webView = [[HWebView alloc] initWithURLString:bannerurl];
//        
//           self.window = [UIApplication sharedApplication].keyWindow;
//             HTabBarController *tab = [[HTabBarController alloc] init];
//                  HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
//                 self.window.rootViewController = nv;
//            NSLog(@"%@",self.window);
//            
//           [nv pushViewController:webView animated:YES];
//            
//            NSLog(@"点击了广告%@",bannerurl);
//            
//        }
//        
//    }];





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //                UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //
    //
    //                HTabBarController *tab = [[HTabBarController alloc] init];
    //                HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
    //                window.rootViewController = nv;
    //
    //            });
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
