//
//  DoraemonDemoHomeViewController.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2018/5/15.
//  Copyright © 2018年 yixiang. All rights reserved.
//

#import "DoraemonDemoHomeViewController.h"
#import "DoraemonDemoLoggerViewController.h"
#import "DoraemonDemoPerformanceViewController.h"
#import "DoraemonDemoSanboxViewController.h"
#import "DoraemonDemoCrashViewController.h"
#import "DoraemonDemoCommonViewController.h"
#import <objc/runtime.h>
#import "UIView+Doraemon.h"
#import "UIViewController+Doraemon.h"

@interface DoraemonDemoHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DoraemonDemoHomeViewController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"[]view did appear");

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"[]view will appear");
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"[] init");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"[]view did load begin");
    self.title = DoraemonDemoLocalizedString(@"DoraemonKit");
    self.navigationItem.leftBarButtonItems = nil;
    [self.view addSubview:self.tableView];
    NSLog(@"[]view did load finish");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *txt = nil;
    NSInteger row = indexPath.row;
    if (row==0) {
        txt = DoraemonDemoLocalizedString(@"沙盒测试Demo");
    }else if(row==1){
        txt = DoraemonDemoLocalizedString(@"日志测试Demo");
    }else if(row==2){
        txt = DoraemonDemoLocalizedString(@"性能测试Demo");
    }else if(row==3){
        txt = DoraemonDemoLocalizedString(@"crash触发Demo");
    }else if(row==4){
        txt = DoraemonDemoLocalizedString(@"通用测试Demo");
    }
    cell.textLabel.text = txt;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UIViewController *vc = nil;
    if (row == 0) {
        vc = [[DoraemonDemoSanboxViewController alloc] init];
    }else if(row == 1){
        vc = [[DoraemonDemoLoggerViewController alloc] init];
    }else if(row == 2){
        vc = [[DoraemonDemoPerformanceViewController alloc] init];
    }else if(row == 3){
        vc = [[DoraemonDemoCrashViewController alloc] init];
    }else if(row == 4){
        vc = [[DoraemonDemoCommonViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
 
    //产生crash
//    NSArray *dataArray = @[@"1",@"2"];
//    NSString *num = dataArray[2];
//    NSLog(@"num == %@",num);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tableView.frame = [self fullscreen];
    NSLog(@"[]view viewDidLayoutSubviews");
}

@end
