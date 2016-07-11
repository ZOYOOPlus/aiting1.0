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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];

    UIApplication *app = [UIApplication sharedApplication];    [app registerUserNotificationSettings:notice];

    app.applicationIconBadgeNumber = 0;

    [AVOSCloud setApplicationId:@"uRSvH8HwoIE9EwXOaUFl4Pci-gzGzoHsz" clientKey:@"lAosTcRn5iwp5QOfsHMszrme"];
    HTabBarController *tab = [[HTabBarController alloc] init];
    HNavigationController *nv = [[HNavigationController alloc] initWithRootViewController:tab];
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
    
    [self basicSetup];

    return YES;
}

- (void)basicSetup {
    // Remove control
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];

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
