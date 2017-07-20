//
//  NSObject+arrayOrDicNotNull.m
//  hemuyouer
//
//  Created by 慕子 on 2017/6/7.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import "NSObject+arrayOrDicNotNull.h"

@implementation NSObject (arrayOrDicNotNull)


/**
 判断非空数组或者字典
 
 @return 结果
 */
- (BOOL)isArrayOrDicAndNotNull {
    return ([self isArrayNotNull] || [self isDicNotNull]);
}


/**
 判断非空数组
 
 @return 结果
 */
- (BOOL)isArrayNotNull {
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
        if (((NSArray * )self).count > 0 ) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}


/**
 判断非空字典
 
 @return 结果
 */
- (BOOL)isDicNotNull {
    if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]) {
        if (((NSDictionary * )self).allKeys > 0 ) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSString *)ifNullCLassWith  {
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSMutableString class]]) {
        return [self copy];
    } else {
        return @"";
        
    }
}
@end
