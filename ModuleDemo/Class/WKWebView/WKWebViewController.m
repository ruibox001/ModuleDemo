//
//  WKWebViewViewController.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"
#import <ModuleCenter/ModuleCenter.h>

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *wkwebView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"WKWebView调用组件演示";
    
    [self request];
}

- (WKWebView *)wkwebView {
    if (!_wkwebView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.processPool = [[WKProcessPool alloc]init];
        configuration.allowsInlineMediaPlayback = YES;
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"WKControl"];
        configuration.userContentController = userContentController;
        configuration.preferences.javaScriptEnabled = YES;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        WKWebView *wkwebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        wkwebView.backgroundColor = [UIColor clearColor];
        wkwebView.allowsBackForwardNavigationGestures = NO;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            wkwebView.allowsLinkPreview = YES; //允许预览链接
        }
        _wkwebView = wkwebView;
        _wkwebView.UIDelegate = self;
        _wkwebView.navigationDelegate = self;
        _wkwebView.scrollView.scrollEnabled = NO;
        [_wkwebView setFrame:self.view.bounds];
        [self.view addSubview:wkwebView];
    }
    return _wkwebView;
}

// 刷新
- (void)request
{
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"wkindex" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
    [self.wkwebView loadHTMLString:html baseURL:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc: %@",self);
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"js调用的oc方法了: \n参数body=%@",message.body);
    [self wkWebViewInvacationWithScriptMessage:message];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

//接收到服务器响应 后决定是否允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"接收到响应后Url = %@ response=%@", self.wkwebView.URL.absoluteString,navigationResponse.response);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"1页面加载失败 Url = %@ %@", webView.URL.absoluteString,error);
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"2页面加载失败 Url = %@ %@", webView.URL.absoluteString,error);
}

//防止内存过大白屏问题
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}

//处理不安全的https请求
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        }
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}


#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler(YES);
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler
{
    //用于和JS交互，弹出输入框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler(nil);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields.firstObject;
        completionHandler(textField.text);
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [self presentViewController:alertController animated:YES completion:NULL];
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return nil;
}

#pragma mark - 其他方法
- (void)runJs:(NSString *)js handler:(void (^)(id _Nullable, NSError * _Nullable))completionHandler
{
    [self.wkwebView evaluateJavaScript:js completionHandler:completionHandler];
}

@end
