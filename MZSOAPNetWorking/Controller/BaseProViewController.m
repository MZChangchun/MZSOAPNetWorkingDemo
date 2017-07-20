//
//  BaseProViewController.m
//  xuesheng
//
//  Created by Mr.Yang on 2016/11/8.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "BaseProViewController.h"
#import "MZXMLParser.h"
#import "MZNetWorkTool.h"
#define WS(weakSelf,Views)  __weak typeof(Views) weakSelf = Views


@interface BaseProViewController ()


@end

@implementation BaseProViewController

-(MBProgressHUD *)hud{
    if (!_hud) {
        //        _hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:1];
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:1];
    }
    return _hud;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(0, 40.0, 30.0, 30.0);
        [butt setImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:butt];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, left];
    }
}


-(void)setBackButtImageName:(NSString *)backButtImageName {
    _backButtImageName = backButtImageName;
    if (backButtImageName) {
        UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(0, 40.0, 30.0, 30.0);
        [butt setImage:[UIImage imageNamed:backButtImageName] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:butt];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, left];
    }
}

- (void)setbackImage:(NSString *)image size:(CGSize)size {
    if (image) {
        UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(0, 40.0, size.width, size.height);
        [butt setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:butt];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, left];
    }

}

//最新版网络请求
//默认soapname = json
- (void)authenticationName:(NSString *)authenticationName requestDic:(NSDictionary *)dict {
    [self authenticationName:authenticationName requestDic:dict soapjson:@"json"];
}
- (void)authenticationName:(NSString *)authenticationName requestDic:(NSDictionary *)dict soapjson:(NSString *)soapname {
    NSLog(@"%@", self.requestArray);
    WS(weakSelf, self);
    
    NSString * result = [NSString stringWithFormat:@"%@Result",authenticationName];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.hudTitle && ![weakSelf.hudTitle isEqualToString:@""]) {
            weakSelf.hud.labelText = weakSelf.hudTitle;
        } else {
            weakSelf.hud.labelText = @"正在奋力请求中...";
        }
        
    });
    
    NSMutableURLRequest *request;
    request = [MZNetWorkTool JSONOFSOAPWith:dict URL:authenticationName authenticationName:authenticationName jsonName:[soapname copy]];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Session----失败----%@", error.localizedDescription);
            //登录失败，返回不成功
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf requestResult:NO withReasun:error.localizedDescription withDic:nil authenticationName:authenticationName];
            });
            return ;
        }
        
        
//        
//        NSLog(@"\n%@", data);
        NSLog(@"\n%@", response);
        

        [[MZXMLParser shared] XMLParserWithData:data withMethodName:result parserResult:^(BOOL success, NSString *result) {
            if (success) {
                NSLog(@"%@", result);
                NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf requestResult:YES withReasun:nil withDic:dic authenticationName:authenticationName];
                });

            } else {
                NSLog(@"%@", result);
                [weakSelf requestResult:NO withReasun:result withDic:nil authenticationName:authenticationName];
            }
        }];
    }];
    
    [task resume];
}

- (void)authenticationName:(NSString *)authenticationName resultArray:(NSArray *)array {
    [self authenticationName:authenticationName resultArray:array soapjson:@"json"];
}
- (void)authenticationName:(NSString *)authenticationName resultArray:(NSArray *)array soapjson:(NSString *)soapname {
    NSLog(@"%@", self.requestArray);
    WS(weakSelf, self);
    
    NSString * result = [NSString stringWithFormat:@"%@Result",authenticationName];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.hudTitle && ![weakSelf.hudTitle isEqualToString:@""]) {
            weakSelf.hud.labelText = weakSelf.hudTitle;
        } else {
            weakSelf.hud.labelText = @"正在奋力请求中...";
        }
        
    });
    
    NSMutableURLRequest *request;
    request = [MZNetWorkTool JSONOFSOAPWithArray:array URL:authenticationName authenticationName:authenticationName jsonName:[soapname copy]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Session----失败----%@", error.localizedDescription);
            //登录失败，返回不成功
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf requestResult:NO withReasun:error.localizedDescription withDic:nil authenticationName:authenticationName];
            });
            return ;
        }

        NSLog(@"\n%@", response);
        
        
        [[MZXMLParser shared] XMLParserWithData:data withMethodName:result parserResult:^(BOOL success, NSString *result) {
            if (success) {
                NSLog(@"%@", result);
                NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf requestResult:YES withReasun:nil withDic:dic authenticationName:authenticationName];
                });
                
            } else {
                NSLog(@"%@", result);
                [weakSelf requestResult:NO withReasun:result withDic:nil authenticationName:authenticationName];
            }
        }];
    }];
    
    [task resume];
}





- (void)requestResult:(BOOL)res withReasun:(NSString *)str withDic:(NSDictionary *)dic authenticationName:(NSString *)authenticationName{
    
    [self hiddenFHL];
    
    if (res) {
        
        if (![dic isDicNotNull]) {
            [self requestFailedWithDic:@"数据解析失败" authenticationName:authenticationName];
        } else {
            if ([dic[@"success"] intValue] == 1) {
                //网络请求成功
                [self requestSuccessWithDic:dic authenticationName:authenticationName];
                
            }else{
                if ([[dic mz_key_string:@"msg"] isEqualToString:@""]) {
                    [self requestFailedWithDic:@"未知原因" authenticationName:authenticationName];
                }else{
                    [self requestFailedWithDic:dic[@"msg"] authenticationName:authenticationName];
                }
            }
        }
    }else{
        if (!str || [str isEqualToString:@""]) {
            [self requestFailedWithDic:@"未知原因" authenticationName:authenticationName];
        }else{
            [self requestFailedWithDic:str authenticationName:authenticationName];
        }
    }
}

- (void)requestSuccessWithDic:(NSDictionary *)dic authenticationName:(NSString *)authenticationName{
    
}
- (void)requestFailedWithDic:(NSString *)failResult authenticationName:(NSString *)authenticationName{
    NSString * failStr = [NSString stringWithFormat:@"%@", failResult];
    
    UIAlertController * warning  =[UIAlertController alertControllerWithTitle:@"失败了" message:failStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [warning addAction:cancelAction];
    [self presentViewController:warning animated:YES completion:nil];
    
}

- (void)back{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:1];
        return;
    }
    if (self.tabBarController.navigationController) {
        [self.tabBarController.navigationController popViewControllerAnimated:1];
        return;
    }
    if (self.tabBarController) {
        [self.tabBarController dismissViewControllerAnimated:1 completion:nil];
        return;
    }
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:1 completion:nil];
        return;
    }
    [self dismissViewControllerAnimated:1 completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//其他操作，隐藏风火轮
- (void)hiddenFHL{
    
    NSLog(@"我隐藏了风火轮啊");
    
    if (!_hud) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"隐藏风火轮");
        [_hud hide:0];
        _hud = nil;
    });
}

- (NSString *)sopa12JsonName {
    if (!_sopa12JsonName) {
        _sopa12JsonName = @"json";
    }
    return _sopa12JsonName;
}

@end
