//
//  PAModuleDevice.h
//  PingAnBankVTM
//
//  Created by admin on 2018/9/10.
//  Copyright © 2018年 PingAnBankVTM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleDevice : NSObject

//获取设备信息-组件间回调返回
- (void) moduleDeviceInfoCbFunc:(NSDictionary *)dict;

//获取设备信息-组件直接返回
- (NSDictionary *) moduleDeviceInfoReturn:(NSDictionary *)dict;

@end
