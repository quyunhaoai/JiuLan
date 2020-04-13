//
//  XYWebWorkViewController.m
//  XiYuanPlus
//
//  Created by lijie lijie on 2018/11/15.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import "XYWebWorkViewController.h"
#import <WebKit/WebKit.h>
@interface XYWebWorkViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong,nonatomic) UIProgressView *progressView; //网页加载进度条;
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,copy)NSString *webViewUrl;

@end

@implementation XYWebWorkViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setUpUI];
}

#pragma mark - requestData API
- (void)requestData {
    
}

#pragma mark - setUpUI
- (void)setUpUI {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [[WKUserContentController alloc] init];
    configuration.preferences.javaScriptEnabled = YES;
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    configuration.processPool = [[WKProcessPool alloc] init];
    
    CGFloat aa;
    if (iPhoneX || IS_IPHONE_Xs_Max || IS_IPHONE_Xr) {
        aa = -44;
    } else aa = 0;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, aa , Window_W, Window_H) configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [self.view addSubview:_webView];
    
    [self setupProgressView];
    [_webView addObserver:self
               forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                  options:NSKeyValueObservingOptionNew
                  context:nil];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    if (@available(iOS 11.0, *)) {
        if(IS_IPHONE_Xs_Max || iPhoneX || IS_IPHONE_Xr) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    } else {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    }else
    {        // Fallback on earlier versions
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}


- (void)setupProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0,   1, Window_W, 2);
    [progressView setTrackTintColor:[UIColor colorWithRed:248.0/255
                                                    green:248.0/255
                                                     blue:248.0/255
                                                    alpha:1.0]];
    progressView.progressTintColor = kRedColor;
    [self.view addSubview:progressView];
    _progressView = progressView;
    [self.view bringSubviewToFront:self.progressView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让进度条显示
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [self.view makeToast:@"网络故障,请检查网络后重试" duration:1.5 position:CSToastPositionCenter];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//kvo 监听进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self.webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    self.webView.navigationDelegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// 显示一个按钮。点击后调用completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
