//
//  MZTableBasicViewController.m
//  xuesheng
//
//  Created by Mr.Yang on 2016/11/10.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "MZTableBasicViewController.h"

@interface MZTableBasicViewController ()

@end

@implementation MZTableBasicViewController

- (void)setIsBeginLeft:(BOOL)isBeginLeft {
    _isBeginLeft = isBeginLeft;
    if (isBeginLeft) {
        [self.table setLayoutMargins:UIEdgeInsetsZero];
        [self.table setSeparatorInset:UIEdgeInsetsZero];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT - DEVICE_NAVSTATUEHEIGH) style:self.tableStyle];
    } else {
        self.table = [[UITableView alloc] initWithFrame:self.view.frame style:self.tableStyle];
    }
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.showsVerticalScrollIndicator = 0;
    self.table.showsHorizontalScrollIndicator = 0;
    if (self.isBeginLeft) {
        [self.table setLayoutMargins:UIEdgeInsetsZero];
        [self.table setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.table setTableFooterView:[self tableFootView]];
    [self.table setTableHeaderView:[self tableHeadView]];
    [self.view addSubview:self.table];
    self.table.rowHeight = self.cellHeigh;
}

- (UIView *)tableHeadView {
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (UIView *)tableFootView {
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.array) {
        return 0;
    }
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * settCellID = @"settingCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:settCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:settCellID];
        cell.accessoryType = self.cellAccessoryType;//跳转指示图标
    }
    if (self.array[indexPath.row][@"image"]) {
        cell.imageView.image = [UIImage imageNamed:self.array[indexPath.row][@"image"]];
    }
    if (self.array[indexPath.row][@"title"]) {
        cell.textLabel.text = self.array[indexPath.row][@"title"];
    }
    if (self.cellStyle == UITableViewCellStyleSubtitle) {
        if (self.array[indexPath.row][@"detailtitle"]) {
            cell.detailTextLabel.text = self.array[indexPath.row][@"detailtitle"];
        }
    }
    
    if (self.isBeginLeft) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:1];//消除阴影
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return self.cellHeigh;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
