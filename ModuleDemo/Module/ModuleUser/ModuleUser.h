//
//  ModuleUser.h
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModuleUser : NSObject

- (void) moduleUserInfoCbFunc:(NSDictionary *)dict;

- (NSDictionary *) moduleUserInfoReturn:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
