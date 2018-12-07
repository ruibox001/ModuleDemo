//
//  NSDictionary+CallBack.h
//  ModuleCenter
//
//  Created by 王声远 on 2018/11/26.
//  Copyright © 2018年 ModuleCenter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (CenterCallBack)

/**
 组件通过这个方法处理回调信息给各个调用方
 
 @param data 组件处理后得到的数据，可以为nil
 @param msg 描述信息
 @param code 处理成功失败的code
 */
- (void)cbWithData:(nullable NSDictionary *)data msg:(nullable NSString *)msg code:(nullable NSString *)code;

@end

NS_ASSUME_NONNULL_END
