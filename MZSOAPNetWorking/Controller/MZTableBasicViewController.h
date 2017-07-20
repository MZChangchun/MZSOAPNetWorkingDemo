//
//  MZTableBasicViewController.h
//  xuesheng
//
//  Created by Mr.Yang on 2016/11/10.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "BaseProViewController.h"

@interface MZTableBasicViewController : BaseProViewController<UITableViewDelegate, UITableViewDataSource>

//默认一个区
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSArray * array;
@property (nonatomic, assign)UITableViewCellStyle cellStyle;
@property (nonatomic, assign)UITableViewStyle tableStyle;
@property (nonatomic, assign)BOOL isBeginLeft;//线条从最左开始
@property (nonatomic, assign)CGFloat cellHeigh;
@property (nonatomic, assign)UITableViewCellAccessoryType cellAccessoryType;//跳转指示图标

- (UIView *)tableHeadView;
- (UIView *)tableFootView;

@end
