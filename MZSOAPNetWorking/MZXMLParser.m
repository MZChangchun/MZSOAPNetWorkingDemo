//
//  MZXMLParser.m
//  长江实验小学
//
//  Created by 慕子 on 2017/6/19.
//  Copyright © 2017年 MZ. All rights reserved.
//

#import "MZXMLParser.h"

@interface MZXMLParser()<NSXMLParserDelegate>

@property (nonatomic, copy)mz_XMLParserResult block;
@property (nonatomic, copy)NSString * resultName;
@property (nonatomic, strong) NSMutableString *tempString;     // 用于临时保存解析
@property (nonatomic, copy)NSString * result;
@end

@implementation MZXMLParser

+ (instancetype)shared {
    static MZXMLParser * downloadManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [MZXMLParser new];
    });
    return downloadManager;
}

/**
 XML解析
 
 @param data 传入的数据
 @param result 结果
 */
- (void)XMLParserWithData:(NSData *)data withMethodName:(NSString *)resultName parserResult:(void(^)(BOOL success, NSString * result))result {
    _resultName = [self ifNullCLassWith:resultName];
    self.block = result;
    //1.创建NSXMLParser
    NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:data];
    //2.设置代理
    [XMLParser setDelegate:self];
    //3.开始解析
    [XMLParser parse];
}

#pragma mark - NSXMLParserDelegate
/* 开始解析xml文件，在开始解析xml节点前，通过该方法可以做一些初始化工作 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
//    NSLog(@"开始解析xml文件");
}

/* 当解析器对象遇到xml的开始标记时，调用这个方法开始解析该节点 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
//    NSLog(@"发现节点");
    if ([elementName isEqualToString:_resultName]) {
        _tempString = nil;
    }
}

/* 当解析器找到开始标记和结束标记之间的字符时，调用这个方法解析当前节点的所有字符 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"正在解析节点内容");
    [self.tempString appendString:string];
}

/* 当解析器对象遇到xml的结束标记时，调用这个方法完成解析该节点 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    NSLog(@"解析节点结束");
    if ([elementName isEqualToString:_resultName]) {
        _result = [self.tempString copy];
    }
    _tempString = nil;
}

/* 解析xml出错的处理方法 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
//    NSLog(@"解析xml出错:%@", parseError);
    self.block(0, parseError.localizedDescription);
}

/* 解析xml文件结束 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"解析xml文件结束");
    if (self.block) {
        self.block(1, [self.result copy]);
    }
    
}



- (NSString *)ifNullCLassWith:(NSString *)string  {
    if ([string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSMutableString class]]) {
        return [string copy];
    } else {
        return @"";
        
    }
}


#pragma mark - 懒加载
-(NSMutableString *)tempString {
    if (!_tempString) {
        _tempString = [[NSMutableString alloc] init];
    }
    return _tempString;
}

@end
