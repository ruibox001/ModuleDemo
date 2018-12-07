//
//  Tool.h
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tool : NSObject

+ (UIButton *)createBtn:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action;

+ (NSString*)dictToString:(NSDictionary *)dict;
+ (NSDictionary *)stringToDict:(NSString *)string;

+ (void)showMesageWithTitle:(NSString *)title msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
