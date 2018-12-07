//
//  NativeViewController.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "NativeReturnViewController.h"
#import <ModuleCenter/ModuleCenter.h>
#import "Tool.h"

@interface NativeReturnViewController ()

@end

@implementation NativeReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Native调用组件带返回值演示";
    
    UIButton *btn = [Tool createBtn:@"返回值方式获取设备组件信息" frame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 44) target:self action:@selector(returnDevice:)];
    [self.view addSubview:btn];
    
    btn = [Tool createBtn:@"返回值方式获取用户组件信息" frame:CGRectMake(50, 100+44*2, [UIScreen mainScreen].bounds.size.width-100, 44) target:self action:@selector(returnUser:)];
    [self.view addSubview:btn];
}

- (void) returnDevice:(UIButton *)btn {
    NSDictionary *dict = [self nativeReturnValueInvacatWithName:@"ModuleDevice.moduleDeviceInfoReturn" params:@{@"dec":@"原生想获取设备信息"}];
    [Tool showMesageWithTitle:@"返回值获取设备组件信息" msg:[Tool dictToString:dict]];
}

- (void) returnUser:(UIButton *)btn {
    NSDictionary *dict = [self nativeReturnValueInvacatWithName:@"ModuleUser.moduleUserInfoReturn" params:@{@"dec":@"原生想获取用户信息"}];
    [Tool showMesageWithTitle:@"返回值获取用户组件信息" msg:[Tool dictToString:dict]];
}

- (void)dealloc
{
    NSLog(@"dealloc: %@",self);
}

@end
