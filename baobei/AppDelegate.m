//
//  AppDelegate.m
//  baobei
//
//  Created by 贺少虎 on 16/4/24.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "AppDelegate.h"
#import "HTabBarController.h"
#import "HNavigationController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "HomeVC.h"
#import "LearnVC.h"
#import "ShowVC.h"
#import "NewsVC.h"
#import "ProfilesVC.h"
#import "RecordingView.h"
#import "TYAdViewController.h"


@interface AppDelegate ()
@property (nonatomic,strong)NSString *urlStr;
@property  (nonatomic,strong)NSURL   *URL;
@property (nonatomic,strong)UIView *ADVew;
@property (strong, nonatomic) UIView *lunchView;

@end

@implementation AppDelegate
@synthesize lunchView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//  [NSThread sleepForTimeInterval:1.0];
  
   [self.window makeKeyAndVisible];

     self.window = [[UIWindow alloc] init];
//    lunchView = [[NSBundle mainBundle ]loadNibNamed:@"AD" owner:nil options:nil][0];
////        UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
////    lunchView = [NSBundle mainBundle]st
//    lunchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
//    [self.window addSubview:lunchView];
//    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 300)];
//    NSString *str = @"http://www.jerehedu.com/images/temp/logo.gif";
//    [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default1.jpg"]];
//    [lunchView addSubview:imageV];
//    
//    [self.window bringSubviewToFront:lunchView];
//    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];

    
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];

    UIApplication *app = [UIApplication sharedApplication];
    [app registerUserNotificationSettings:notice];

    app.applicationIconBadgeNumber = 0;
    
[[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    [AVOSCloud setApplicationId:@"uRSvH8HwoIE9EwXOaUFl4Pci-gzGzoHsz" clientKey:@"lAosTcRn5iwp5QOfsHMszrme"];
    
    

    
    TYAdViewController *mainVC= [[TYAdViewController alloc]init];
    self.window.rootViewController = mainVC;

//    HTabBarController *tab = [[HTabBarController alloc] init];
//    HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
//    self.window.rootViewController = nv;
//
//    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//    UIView *launchView = viewController.view;
//    UIImageView  * Imageview= [[UIImageView  alloc]initWithFrame:[UIScreen mainScreen].bounds];
//   
//    Imageview.image = [UIImage imageNamed:@"2Default2.jpg"];
//    
//    [self.window addSubview:launchView];
//    [launchView addSubview:Imageview];
// //   [self.window bringSubviewToFront:Imageview];
//  //  [launchView bringSubviewToFront:Imageview];
////    [Imageview bringSubviewToFront:launchView];
//    [self.window bringSubviewToFront:launchView];
//    
////    [vContent addSubview : vcList.view];[vContent bringSubviewToFront : vcList.view]
//    
//    //这一步是获取上次网络请求下来的图片，如果存在就展示该图片，如果不存在就展示本地保存的名为test的图片
////    NSMutableData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageu"];
////    if (data.length>0) {
////        Imageview.image = [UIImage imageWithData:data];
////    }else{
////        
////        Imageview.image = [UIImage imageNamed:@"2Default2.jpg"];
////    }
////    
//    
//    
//    //下面这段代码，是调用AFN下载文件的方法，异步
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSURL *URL = [NSURL URLWithString:@"http://s16.sinaimg.cn/large/005vePOgzy70Rd3a9pJdf&690"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//        
//        NSData * image = [NSData dataWithContentsOfURL:filePath];
//        [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"imageu"];
//        
//        
//    }];
//    [downloadTask resume];
    
    

   [self.window makeKeyAndVisible];
   
    [self basicSetup];
    
 //   [self joinGroup: self.urlStr key:self.URL];

    return YES;
}

-(void)removeLun
{
    [lunchView removeFromSuperview];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)basicSetup {
    // Remove control
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];

}

- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    _urlStr= [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"121862562",@"7c92660d67b345c8370d4a839c9efbed8d587209cfd5d99bb671c34c9fb979c5"];
    _URL = [NSURL URLWithString:_urlStr];
    if([[UIApplication sharedApplication] canOpenURL:_URL]){
        [[UIApplication sharedApplication] openURL:_URL];
        return YES;
    }
    else return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

# pragma mark - Remote control
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPause:
                break;
            case UIEventSubtypeRemoteControlStop:
                break;
            case UIEventSubtypeRemoteControlPlay:
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                break;
            case UIEventSubtypeRemoteControlNextTrack:
//                [[MusicViewController sharedInstance] playNextMusic:nil];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
//                [[MusicViewController sharedInstance] playPreviousMusic:nil];
                break;
            default:
                break;
        }
    }
}


@end
