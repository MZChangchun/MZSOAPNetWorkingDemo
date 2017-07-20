//
//  NSObject+arrayOrDicNotNull.h
//  hemuyouer
//
//  Created by 慕子 on 2017/6/7.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 判断类型
 */
@interface NSObject (arrayOrDicNotNull)


/**
 判断非空数组或者字典

 @return 结果
 */
- (BOOL)isArrayOrDicAndNotNull;


/**
 判断非空数组

 @return 结果
 */
- (BOOL)isArrayNotNull;


/**
 判断非空字典

 @return 结果
 */
- (BOOL)isDicNotNull;

/**
 obj定变字符串

 @return string
 */
- (NSString *)ifNullCLassWith;

@end
