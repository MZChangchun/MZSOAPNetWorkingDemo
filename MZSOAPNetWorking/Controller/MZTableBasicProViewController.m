//
//  MZTableBasicProViewController.m
//  xuesheng
//
//  Created by Mr.Yang on 2017/4/14.
//  Copyright © 2017年 Mr.Yang. All rights reserved.
//

#import "MZTableBasicProViewController.h"

@interface MZTableBasicProViewController ()

@end

@implementation MZTableBasicProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf, self);
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headRefresh];
    }];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footAdd];
    }];
    [self.table.mj_header beginRefreshing];
}
- (void)requestFirstForWeek {
    [self requestWANGLUO];
}
//下拉刷新
- (void)headRefresh {
    [self.table.mj_footer resetNoMoreData];
    if (_currentBeginzero) {
        _currentpage = 0;
    } else {
        _currentpage = 1;
    }
    _isrefresh = 1;
    [self requestWANGLUO];
}
//上拉加载
- (void)footAdd {
    _isrefresh = 0;
    _currentpage += 1;
    if (_currentBeginzero) {
        if (_totalpage < _currentpage + 1) {
            _currentpage -= 1;
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self requestWANGLUO];
        }
    } else {
        if (_totalpage < _currentpage) {
            _currentpage -= 1;
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self requestWANGLUO];
        }
    }
}
- (void)requestWANGLUO {
    
}

#pragma mark- 网络请求结果
- (void)requestResult:(BOOL)res withReasun:(NSString *)str withDic:(NSDictionary *)dic authenticationName:(NSString *)authenticationName {
    if ([authenticationName isEqualToString:self.URLNAME]) {
        if (_isrefresh) {
            [self.table.mj_header endRefreshing];
        } else {
            if (!res) {
                _currentpage -= 1;
            }
            [self.table.mj_footer resetNoMoreData];
        }
        [super requestResult:res withReasun:str withDic:dic authenticationName:authenticationName];
    } else {
        [super requestResult:res withReasun:str withDic:dic authenticationName:authenticationName];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
