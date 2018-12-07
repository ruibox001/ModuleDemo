//
//  Tool.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (UIButton *)createBtn:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted | UIControlStateSelected];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = frame;
    return btn;
}

+ (NSString*)dictToString:(NSDictionary *)dict
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (NSDictionary *)stringToDict:(NSString *)string {
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    return dic;
}

+ (void)showMesageWithTitle:(NSString *)title msg:(NSString *)msg {
    UIViewController *controller = [self getVisibleViewController];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [controller presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - 获取当前手机可视化界面ViewController
+ (UIViewController *)getVisibleViewController {
    UIWindow *window = [UIApplication sharedApplication ].delegate.window;
    UIViewController *rootViewController = window.rootViewController;
    return [self getVisibleViewController:rootViewController];
}

+ (UIViewController *)getVisibleViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self getVisibleViewController:lastViewController];
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        return [self getVisibleViewController:selectedViewController];
    }
    
    if (rootViewController.presentedViewController != nil) {
        UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
        return [self getVisibleViewController:presentedViewController];
    }
    return rootViewController;
}

@end
