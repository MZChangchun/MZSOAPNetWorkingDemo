//
//  MZWebLoadHTMLViewController.h
//  长江实验小学
//
//  Created by 慕子 on 2017/6/14.
//  Copyright © 2017年 MZ. All rights reserved.
//

#import "BaseProViewController.h"
#import "NSString+HTML.h"
/**
 通知公告详情等基础类
 */
@interface MZWebLoadHTMLViewController : BaseProViewController

/** title高度 */
@property (nonatomic, assign)CGFloat titleHeigh;

/** web高度 */
@property (nonatomic, assign)CGFloat webHeigh;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 作者 */
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

/** 标题高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeigh;

/** 作者高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorLabelHeigh;

/** web */
@property (weak, nonatomic) IBOutlet UIWebView *webView;

/** web高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeigh;

/** 背景 */
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollerView;




/** 网络请求 */
- (void)requireHTML ;

@end
