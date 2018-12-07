//
//  NativeViewController.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "NativeViewController.h"
#import <ModuleCenter/ModuleCenter.h>
#import "Tool.h"

@interface NativeViewController ()

@end

@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Native调用组件演示";
    
    UIButton *btn = [Tool createBtn:@"获取设备组件信息" frame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 44) target:self action:@selector(blockDevice:)];
    [self.view addSubview:btn];
    
    btn = [Tool createBtn:@"获取用户组件信息" frame:CGRectMake(50, 100+44*2, [UIScreen mainScreen].bounds.size.width-100, 44) target:self action:@selector(blockUser:)];
    [self.view addSubview:btn];
}


- (void) blockDevice:(UIButton *)btn {
    [self nativeInvacatWithName:@"ModuleDevice.moduleDeviceInfoCbFunc" params:nil cb:^(NSString * _Nonnull msg) {
        [Tool showMesageWithTitle:@"获取设备组件信息" msg:msg];
    }];
}

- (void) blockUser:(UIButton *)btn {
    [self nativeInvacatWithName:@"ModuleUser.moduleUserInfoCbFunc" params:nil cb:^(NSString * _Nonnull msg) {
        [Tool showMesageWithTitle:@"获取用户组件信息" msg:msg];
    }];
}

- (void)dealloc
{
    NSLog(@"dealloc: %@",self);
}

@end
