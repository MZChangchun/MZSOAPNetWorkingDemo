//
//  MZNetWorking.h
//  长江实验小学
//
//  Created by 慕子 on 2017/6/26.
//  Copyright © 2017年 MZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^mz_requestNetResult) (BOOL success, NSError *  error, NSDictionary *  dict);

/**
 网络请求管理器
 */
@interface MZNetWorking : NSObject

+ (instancetype)share;


/**
 网络请求

 @param authenticationName 请求名字
 @param dict 请求参数
 @param block 结果
 */
- (void)authenticationName:(NSString *)authenticationName requestDic:(NSDictionary *)dict result:(mz_requestNetResult)block;

/**
 网络请求

 @param authenticationName 请求名字
 @param array 请求参数
 @param block 结果
 */
- (void)authenticationName:(NSString *)authenticationName requestArray:(NSArray *)array result:(mz_requestNetResult)block;

@end
