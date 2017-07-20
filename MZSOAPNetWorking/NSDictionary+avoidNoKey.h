//
//  NSDictionary+avoidNoKey.h
//  hemuyouer
//
//  Created by 慕子 on 2017/6/7.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 避免字典取到不存在的键值崩溃
 */
@interface NSDictionary (avoidNoKey)


/**
 字典取值 （字符串类型）

 @param key 键值
 @return 字符串
 */
- (NSString *)mz_key_string:(NSString *)key;

/**
 字典取值 （整型）

 @param key 键值
 @return 整形
 */
- (int)mz_key_nsuint:(NSString *)key;

/**
 字典取值 （BOOL类型）

 @param key 键值
 @return BOOL类型
 */
- (BOOL)mz_key_bool:(NSString *)key;

/**
 字典取值 （对象类型）

 @param key 键值
 @return 对象
 */
- (id)mz_key_model:(NSString *)key;



/**
 字典取值 （数组类型）

 @param key 键值
 @return 数组
 */
- (NSArray *)mz_key_array:(NSString *)key;



@end
