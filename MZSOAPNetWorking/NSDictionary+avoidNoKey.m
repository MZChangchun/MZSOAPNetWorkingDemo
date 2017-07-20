//
//  NSDictionary+avoidNoKey.m
//  hemuyouer
//
//  Created by 慕子 on 2017/6/7.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import "NSDictionary+avoidNoKey.h"
#import "NSObject+arrayOrDicNotNull.h"

@implementation NSDictionary (avoidNoKey)



- (NSString *)mz_key_string:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        return [NSString stringWithFormat:@"%@", self[key]];
    } else {
        return @"";
    }
}

- (int)mz_key_nsuint:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        if ([self[key] isKindOfClass:[NSNull class]]) {
            return 0;
        }
        return [self[key] intValue];
    } else {
        return 0;
    }
}


- (BOOL)mz_key_bool:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        return (1 == [self[key] integerValue]);
    } else {
        return 0;
    }
}

- (id)mz_key_model:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        return self[key];
    } else {
        return nil;
    }
}

- (NSArray *)mz_key_array:(NSString *)key {
    
    if ([self.allKeys containsObject:key]) {
        if ([self[key] isArrayNotNull]) {
            return self[key];
        } else {
            return @[];
        }
    } else {
        return @[];
    }
    
    
    
    
}


@end
