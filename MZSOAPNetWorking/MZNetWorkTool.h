//
//  MZNetWorkTool.h
//  MZSOAPNetWorkingDemo
//
//  Created by 慕子 on 2017/7/20.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 soap请求
 */
@interface MZNetWorkTool : NSObject


//soap请求 (直接使用JSON解析)
+ (NSMutableURLRequest *)JSONOFSOAPWith:(NSDictionary *)dict URL:(NSString *)url authenticationName:(NSString *)name jsonName:(NSString *)jsonName;
+ (NSMutableURLRequest *)JSONOFSOAPWithArray:(NSArray *)array URL:(NSString *)url authenticationName:(NSString *)name jsonName:(NSString *)jsonName;

@end
