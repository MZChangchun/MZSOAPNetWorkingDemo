//
//  BaseProViewController.h
//  xuesheng
//
//  Created by Mr.Yang on 2016/11/8.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import <MJExtension.h>
#import "NSObject+arrayOrDicNotNull.h"
#import "NSDictionary+avoidNoKey.h"
@interface BaseProViewController : UIViewController
@property (nonatomic, strong)NSArray * requestArray;
@property (nonatomic, strong)NSDictionary * requestDictionary;

@property (nonatomic, copy)NSString * userID;

@property (nonatomic, copy)NSString * hudTitle;//风火轮文字 默认正在请求中；
@property (strong, nonatomic)MBProgressHUD *hud;
- (void)hiddenFHL;//隐藏风火轮


//请求成功 成功的原因
- (void)requestSuccessWithDic:(NSDictionary *)dic authenticationName:(NSString *)authenticationName;
//请求失败 失败的原因
- (void)requestFailedWithDic:(NSString *)failResult authenticationName:(NSString *)authenticationName;

- (void)requestResult:(BOOL)res withReasun:(NSString *)str withDic:(NSDictionary *)dic authenticationName:(NSString *)authenticationName;

//最新版网络请求
//默认soapname = json
- (void)authenticationName:(NSString *)authenticationName requestDic:(NSDictionary *)dict;

- (void)authenticationName:(NSString *)authenticationName requestDic:(NSDictionary *)dict soapjson:(NSString *)soapname;


- (void)authenticationName:(NSString *)authenticationName resultArray:(NSArray *)array;
- (void)authenticationName:(NSString *)authenticationName resultArray:(NSArray *)array soapjson:(NSString *)soapname;


- (void)back;


//设置返回按钮的图片
@property (nonatomic, copy)NSString * backButtImageName;
- (void)setbackImage:(NSString *)image size:(CGSize)size;


/**
 soap12 json / 其他 默认json
 */
@property (nonatomic, copy)NSString * sopa12JsonName;


@end
