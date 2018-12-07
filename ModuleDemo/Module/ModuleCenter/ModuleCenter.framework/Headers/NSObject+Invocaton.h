//
//  ModuleCenter+Invocaton.h
//  ModuleCenter
//
//  Created by 王声远 on 2018/11/26.
//  Copyright © 2018年 ModuleCenter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN


//调用组件Target的前缀
static NSString * const kCenterTargetHeader = @"";

//调用组件Action的前缀
static NSString * const kCenterActionHeader = @"";


@interface NSObject (Invocaton)


/**
 原生本地端自己调用组件方法

 @param name 指明调用哪个组件哪个方法，格式为"target.action"
 @param params 调用target的action方法传入参数：类型为NSDictionary 注意：所有的组件间暴露的方法都必须只有一个参数且为NSDictionary
 @param cb 调用组件后收到的回调block 【注意：组件里要回调的话必须通过NSDictionary的category方法cbWithData:msg:code方法回调出来】
 */
- (void) nativeInvacatWithName:(NSString *)name params:(nullable NSDictionary *)params cb:(nullable void (^)(NSString *msg))cb;


/**
 原生本地端自己调用组件方法
 
 @param name 指明调用哪个组件哪个方法，格式为"target.action"
 @param params 调用target的action方法传入参数：类型为NSDictionary 注意：所有的组件间暴露的方法都必须只有一个参数且为NSDictionary
 @return 调用组件后收到的返回值
 */
- (id) nativeReturnValueInvacatWithName:(NSString *)name params:(nullable NSDictionary *)params;


/**
 WKWebView调用组件方法

 @param message WKWebView代理方法里参数
 */
- (void) wkWebViewInvacationWithScriptMessage:(WKScriptMessage *)message;


/**
 UIWebView调用组件方法

 @param params 跟UIWebView调用方规定好格式
 @param webView UIWebView
 */
- (void) uiWebViewInvacationWithScriptMessage:(NSDictionary *)params webView:(UIWebView *)webView;

@end

NS_ASSUME_NONNULL_END
