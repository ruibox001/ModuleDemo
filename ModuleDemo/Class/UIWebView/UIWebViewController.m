//
//  UIWebViewViewController.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "UIWebViewController.h"
#import <ModuleCenter/ModuleCenter.h>
#import "UIWebViewCommunication.h"

@interface UIWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *myWebView;
@property (nonatomic,strong) UIWebViewCommunication *communication;
@property(nonatomic, strong)JSContext *context;

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIWebView调用组件演示";
    
    [self request];
}

- (void)request {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"uiindex" ofType:@"html"];
    NSURL* url = [NSURL  fileURLWithPath:path];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLReques
    [self.myWebView loadRequest:request];
    [self.myWebView setScalesPageToFit:YES];
}

- (UIWebViewCommunication *)communication {
    if (!_communication) {
        _communication = [[UIWebViewCommunication alloc] initWithWebView:self.myWebView];
    }
    return _communication;
}

- (UIWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_myWebView];
        _myWebView.backgroundColor = [UIColor whiteColor];
        _myWebView.delegate = self;
    }
    return _myWebView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context[@"UIControl"] = self.communication;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载失败：%@ error：%@",webView.request.URL.absoluteString,error);
}

- (void)dealloc
{
    NSLog(@"dealloc: %@",self);
}

@end
