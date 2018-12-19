//
//  ModuleUser.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "ModuleUser.h"
#import <ModuleCenter/ModuleCenter.h>

@implementation ModuleUser

- (void) moduleUserInfoCbFunc:(NSDictionary *)dict {
    NSLog(@"组件调用用户信息参数：%@",dict);
    NSString *age = @"30";
    NSString *name = @"王声远";
    NSDictionary *data = @{@"name":name,@"age":age};
    [dict cbWithData:data msg:@"获取APP信息成功" code:@"100"];
}

- (NSDictionary *) moduleUserInfoReturn:(NSDictionary *)dict {
    NSLog(@"返回值调用用户信息参数：%@",dict);
    NSString *age = @"30";
    NSString *name = @"王声远";
    return @{@"name":name,@"age":age};
}
    
- (void)dealloc
{
    NSLog(@"dealloc: %@",self);
}
    
@end
