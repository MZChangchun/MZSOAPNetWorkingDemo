//
//  MZNetWorkURLManager.m
//  MZSOAPNetWorkingDemo
//
//  Created by 慕子 on 2017/7/20.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import "MZNetWorkURLManager.h"

@implementation MZNetWorkURLManager

+ (NSDictionary *)shareConfig{
    
    
    static NSDictionary * sharedDic = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        sharedDic = @{
                      
#ifndef __OPTIMIZE__
                      //生产环境
                      //第三版新接口
                      @"AppLogin":@"http://192.168.1.244:9036/WebService/AppService.asmx",//新版登陆
                      
#else
                      //开发环境
                      //第三版新接口
                      @"AppLogin":@"http://183.247.173.122:8084/WebService/AppService.asmx",//新版登陆
                      
#endif
                      };
    });
    return sharedDic;
    
}

@end
