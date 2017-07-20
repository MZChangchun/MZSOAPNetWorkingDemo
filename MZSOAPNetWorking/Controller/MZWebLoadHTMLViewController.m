//
//  MZWebLoadHTMLViewController.m
//  长江实验小学
//
//  Created by 慕子 on 2017/6/14.
//  Copyright © 2017年 MZ. All rights reserved.
//

#import "MZWebLoadHTMLViewController.h"

@interface MZWebLoadHTMLViewController ()<UIScrollViewDelegate>

@end

@implementation MZWebLoadHTMLViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:@"MZWebLoadHTMLViewController" bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.backButtImageName = @"white_back";
    
    
    self.title = @"通知详情";
    self.backScrollerView.delegate = self;
    self.backScrollerView.tag = 120;
    
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.tag = 110;
    self.webView.scrollView.showsVerticalScrollIndicator = 0;
    self.webViewHeigh.constant = DEVICE_HEIGHT - DEVICE_NAVSTATUEHEIGH;
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requireHTML];
    });
}

- (void)requireHTML {
    
}










//#pragma mark-联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%ld, %.2f", (long)scrollView.tag, scrollView.contentOffset.y);
    
    if (scrollView.tag == 110 ) {
        if (scrollView.contentOffset.y < 0) {
            CGPoint currentContentOffset = scrollView.contentOffset;
            [self.backScrollerView setContentOffset:CGPointMake(0,
                                                                scrollView.contentOffset.y)
                                           animated:0];
            [scrollView setContentOffset:CGPointMake(currentContentOffset.x,
                                                     currentContentOffset.y - currentContentOffset.y)
                                animated:0];
        } else if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < _titleHeigh && self.backScrollerView.contentOffset.y < _titleHeigh) {
            CGPoint currentContentOffset = scrollView.contentOffset;
            [self.backScrollerView setContentOffset:CGPointMake(0,
                                                                currentContentOffset.y * 2)
                                           animated:0];
            //            [scrollView setContentOffset:CGPointMake(currentContentOffset.x,
            //                                                     currentContentOffset.y - currentContentOffset.y)
            //                                animated:0];
            
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
