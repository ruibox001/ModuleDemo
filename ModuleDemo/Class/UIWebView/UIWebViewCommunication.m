//
//  PAAppBean.m
//  PingAnBankVTM
//
//  Created by Sniper on 16/8/23.
//  Copyright © 2016年 PingAnBankVTM. All rights reserved.
//

#import "UIWebViewCommunication.h"
#import <ModuleCenter/ModuleCenter.h>

@interface UIWebViewCommunication()

@property (nonatomic,weak) UIWebView *webView;

@end

@implementation UIWebViewCommunication

- (instancetype)initWithWebView:(UIWebView *)webView
{
    self = [super init];
    if (self) {
        self.webView = webView;
    }
    return self;
}

- (void)postMessage:(NSDictionary *)dict
{
    NSLog(@"UIWebView 调用本地了> %@",dict);
    [self uiWebViewInvacationWithScriptMessage:dict webView:self.webView];
}

@end
