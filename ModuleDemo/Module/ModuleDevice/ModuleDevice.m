//
//  PAModuleDevice.m
//  PingAnBankVTM
//
//  Created by admin on 2018/9/10.
//  Copyright © 2018年 PingAnBankVTM. All rights reserved.
//

#import "ModuleDevice.h"
#import <ModuleCenter/ModuleCenter.h>

@implementation ModuleDevice

- (void) moduleDeviceInfoCbFunc:(NSDictionary *)dict {
    NSLog(@"组件调用设备信息参数：%@",dict);
    NSString *version = @"1.0.0";
    NSString *appName = @"APP名称";
    NSDictionary *data = @{@"appName":appName,@"appVersion":version};
    [dict cbWithData:data msg:@"获取APP信息成功" code:@"100"];
}

- (NSDictionary *) moduleDeviceInfoReturn:(NSDictionary *)dict {
    NSLog(@"返回值调用设备信息参数：%@",dict);
    NSString *version = @"1.0.0";
    NSString *appName = @"APP名称";
    return @{@"appName":appName,@"appVersion":version};
}

@end
