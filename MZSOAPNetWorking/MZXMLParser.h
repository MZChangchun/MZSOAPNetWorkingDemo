//
//  MZXMLParser.h
//  长江实验小学
//
//  Created by 慕子 on 2017/6/19.
//  Copyright © 2017年 MZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^mz_XMLParserResult)(BOOL success, NSString * result);

/**
 XML 解析
 */
@interface MZXMLParser : NSObject


/**
 单例

 @return MZXMLParser
 */
+ (instancetype)shared;

/**
 XML解析

 @param data 传入的数据
 @param result 结果
 */
- (void)XMLParserWithData:(NSData *)data withMethodName:(NSString *)resultName parserResult:(void(^)(BOOL success, NSString * result))result;

@end
