//
//  MZTableBasicProViewController.h
//  xuesheng
//
//  Created by Mr.Yang on 2017/4/14.
//  Copyright © 2017年 Mr.Yang. All rights reserved.
//

#import "MZTableBasicViewController.h"
#import <MJRefresh.h>
@interface MZTableBasicProViewController : MZTableBasicViewController
{
    int _totalpage, _currentpage;//总页数，当前页数
    BOOL _isrefresh;//0 加载 ／1刷新
}

@property (nonatomic, strong)NSString * URLNAME;//网络请求的名称
- (void)requestWANGLUO;//网络请求

@property (nonatomic, assign)BOOL currentBeginzero;// 第一页是从1开始还是从0开始  1从0开始


@end
