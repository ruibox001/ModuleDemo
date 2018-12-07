//
//  ViewController.m
//  ModuleDemo
//
//  Created by admin on 2018/12/6.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "ViewController.h"
#import <ModuleCenter/ModuleCenter.h>
#import "NativeViewController.h"
#import "WKWebViewController.h"
#import "UIWebViewController.h"
#import "NativeReturnViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"组件化开发示例";
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (NSArray *)datas {
    if (!_datas) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@"Native调用组件演示"];
        [array addObject:@"Native调用组件带返回值演示"];
        [array addObject:@"WKWebView调用组件演示"];
        [array addObject:@"UIWebView原生调用组件演示"];
        _datas = array;
    }
    return _datas;
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseId = @"ModuleTableViewCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = self.datas[indexPath.row];
    if ([title isEqualToString:@"Native调用组件演示"]) {
        NativeViewController *vc = [[NativeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"WKWebView调用组件演示"]) {
        WKWebViewController *vc = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"UIWebView原生调用组件演示"]) {
        UIWebViewController *vc = [[UIWebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        NativeReturnViewController *vc = [[NativeReturnViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
