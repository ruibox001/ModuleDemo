//
//  PAAppBean.h
//  PingAnBankVTM
//
//  Created by Sniper on 16/8/23.
//  Copyright © 2016年 PingAnBankVTM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol UIWebViewCommunicationDelegate <JSExport>

- (void)postMessage:(NSDictionary *)dict;

@end

@interface UIWebViewCommunication : NSObject<UIWebViewCommunicationDelegate>

- (instancetype)initWithWebView:(UIWebView *)webView;

@end

/*
 UIWebView调用组件 测试代码
WEAKSELF
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    NSString *strJS = [NSString stringWithFormat:@"PAFBControl.postMessage({'name':'Blue.ReadIdCard','cbFunc':'alert','params':{'type':'2'}});"];
    logNormal(@"执行js: %@",strJS);
    [weakSelf.webview stringByEvaluatingJavaScriptFromString:strJS];
    });
 */
