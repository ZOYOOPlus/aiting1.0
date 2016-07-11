//
//  HWebView.m
//  jyt
//
//  Created by 贺少虎 on 16/5/13.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "HWebView.h"
#import "ShareVC.h"

@interface HWebView () <WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIBarButtonItem *fallBack; //后退按钮
@property (nonatomic, strong) UIBarButtonItem *goBack; // 返回按钮
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation HWebView


- (instancetype)initWithURLString:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = [NSURL URLWithString:url];
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url{
    self = [super init];
    if (self) {
        _url = [url copy];
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.navigationItem.leftBarButtonItems = @[self.goBack];

    
    //日了狗了 都不行
//    self.navigationItem.backBarButtonItem = self.goBack;
//    self.navigationItem.leftBarButtonItems = @[self.fallBack];
//    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.navigationItem.leftBarButtonItems];
//    [array addObject:self.fallBack];
//    self.navigationItem.leftBarButtonItems = array;
    //        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    //        self.navigationItem.backBarButtonItem = item;
    //        self.title = @"设置";
    self.showShareAction = YES;
    self.showProgress = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickShare)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.webView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    if (_url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
    }

    [self.view addSubview:self.progressView];

    
    //无法监听 progress 变化......
//    [self.progressView addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (UIBarButtonItem *)goBack{
    if (!_goBack) {
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.height, 30)];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
//        _goBack = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        _goBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickfallBack)];
    }
    return _goBack;
}

- (UIBarButtonItem *)fallBack{
    if (!_fallBack) {
        _fallBack = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    }
    return _fallBack;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2)];
        _progressView.progress = 0.0;
    }
    return _progressView;
}

- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    _webView = nil;
}

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [WKPreferences new];
        configuration.userContentController = [[WKUserContentController alloc] init];
        
        configuration.allowsInlineMediaPlayback = YES; //容许音乐后台播放
        configuration.requiresUserActionForMediaPlayback = NO; // 音乐可以自动播放
        configuration.allowsPictureInPictureMediaPlayback = YES;

        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
//        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}


- (void)setUrl:(NSURL *)url{
    if (_url != url) {
        _url = url;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)finishProgress{
    self.progressView.hidden = YES;
    [self.progressView setProgress:0.0 animated:NO];
}

- (void)startProgress{
    self.progressView.hidden = NO;
    [self.progressView setProgress:0.0 animated:NO];
}

#pragma mark WKWebView delegate

// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [self startProgress];
    DLog(@"didStartProvisionalNavigation");
}

/**
 *  加载完成
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    DLog(@"didCommitNavigation");
    if ([self.webView canGoBack]) {
        self.navigationItem.leftBarButtonItems = @[self.goBack,self.fallBack];
    }else{
        self.navigationItem.leftBarButtonItems = @[self.goBack];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    DLog(@"didFinishNavigation");
    [self finishProgress];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    DLog(@"%@",error);
    [self finishProgress];
}

#pragma mark - WKWebView WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByRemovingPercentEncoding];
//    DLog(@"urlString=%@",urlString);
    decisionHandler(WKNavigationActionPolicyAllow);

}

#pragma mark webview kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",keyPath);
    
    if (self.showProgress) {
        self.progressView.hidden = YES;
        return;
    }
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:[change[NSKeyValueChangeNewKey] doubleValue] animated:YES];
//        self.progressView.progress = [change[NSKeyValueChangeNewKey] doubleValue];
    }else if ([keyPath isEqualToString:@"progress"]){
        CGFloat progress = [change[NSKeyValueChangeNewKey] doubleValue];
//        NSLog(@"%f",progress);
        if (progress == 1.0) {
            self.progressView.hidden = YES;
        }else{
            self.progressView.hidden = NO;
        }
    }
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickfallBack{
    //返回
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickShare{
// 系统方法
//    NSString *info = @"分享测试";
////    UIImage *image=[UIImage imageNamed:@"head.jpg"];
//    NSURL *url = self.webView.URL;
//    NSArray *postItems=@[info,url];
//    
//    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
//    
//    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
//        
//    
//    };
//    activity.completionWithItemsHandler = myBlock;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        [self presentViewController:activity animated:YES completion:nil];
//    }
    
    ShareVC *vc = [[ShareVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:NO completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
