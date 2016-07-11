//
//  HWebView.h
//  jyt
//
//  Created by 贺少虎 on 16/5/13.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
/**
 *  自定义浏览器 iOS 8 以上才能用
 */

@import WebKit;

#import "BaseVC.h"

@interface HWebView : UIViewController

@property (nonatomic, strong) NSString *urlstr;
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL showShareAction;
@property (nonatomic, assign) BOOL showProgress;

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURLString:(NSString *)url;

@end
