//
//  MZNetWorkTool.m
//  MZSOAPNetWorkingDemo
//
//  Created by 慕子 on 2017/7/20.
//  Copyright © 2017年 慕子. All rights reserved.
//

#import "MZNetWorkTool.h"
#import "MZNetWorkURLManager.h"

@implementation MZNetWorkTool


//soap请求 (直接使用JSON解析)
+ (NSMutableURLRequest *)JSONOFSOAPWith:(NSDictionary *)dict URL:(NSString *)url authenticationName:(NSString *)name jsonName:(NSString *)jsonName{
    return [MZNetWorkTool JSONOFSOAPWithid:dict URL:url authenticationName:name jsonName:jsonName];
}
+ (NSMutableURLRequest *)JSONOFSOAPWithArray:(NSArray *)array URL:(NSString *)url authenticationName:(NSString *)name jsonName:(NSString *)jsonName {
    return [MZNetWorkTool JSONOFSOAPWithid:array URL:url authenticationName:name jsonName:jsonName];
}

+ (NSMutableURLRequest *)JSONOFSOAPWithid:(id)parameter URL:(NSString *)url authenticationName:(NSString *)name jsonName:(NSString *)jsonName {
    
    NSString *soapStr = @"";
    if (([parameter isKindOfClass:[NSArray class]] || [parameter isKindOfClass:[NSMutableArray class]]) &&
        ((NSArray *)parameter).count > 0) {
        
        NSArray * array = [parameter copy];
        NSError *parseError = nil;
        
        NSString * stringtemp = @"";
        
        for (int i = 0; i < array.count; i ++) {
            NSDictionary * dict = array[i];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
            
            NSString * dictStringTemp = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            dictStringTemp = [dictStringTemp stringByReplacingOccurrencesOfString:@"\n  \"" withString:@"\""];
            dictStringTemp = [dictStringTemp stringByReplacingOccurrencesOfString:@"\n}" withString:@"}"];
            if (0 == i) {
                NSString * resultDicString = [stringtemp stringByAppendingString:dictStringTemp];
                stringtemp = [resultDicString copy];
            } else {
                NSString * resultDicString1 = [stringtemp stringByAppendingString:@","];
                NSString * resultDicString = [resultDicString1 stringByAppendingString:dictStringTemp];
                stringtemp = [resultDicString copy];
            }
        }
        
        stringtemp = [NSString stringWithFormat:@"[%@]", stringtemp];
        soapStr =
        [NSString stringWithFormat:
         @ "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
         "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
         "<soap12:Body>"
         "<%@ xmlns=\"http://tempuri.org/\">"
         "<%@>%@</%@>"
         "</%@>"//方法名
         "</soap12:Body>"
         "</soap12:Envelope>", name, jsonName,stringtemp, jsonName, name];

    } else if (([parameter isKindOfClass:[NSDictionary class]] || [parameter isKindOfClass:[NSMutableDictionary class]]) &&
               ((NSDictionary *)parameter).allKeys > 0) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[parameter copy] options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString * stringtemp = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        stringtemp = [stringtemp stringByReplacingOccurrencesOfString:@"\n  \"" withString:@"\""];
        stringtemp = [stringtemp stringByReplacingOccurrencesOfString:@"\n}" withString:@"}"];
        stringtemp = [NSString stringWithFormat:@"[%@]", stringtemp];
        soapStr =
        [NSString stringWithFormat:
         @ "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
         "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
         "<soap12:Body>"
         "<%@ xmlns=\"http://tempuri.org/\">"
         "<%@>%@</%@>"
         "</%@>"//方法名
         "</soap12:Body>"
         "</soap12:Envelope>", name, jsonName,stringtemp, jsonName, name];

    } else  {
        soapStr =
        [NSString stringWithFormat:
         @ "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
         "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
         "<soap12:Body>"
         "<%@ xmlns=\"http://tempuri.org/\">"
         "</%@>"//方法名
         "</soap12:Body>"
         "</soap12:Envelope>", name, name];
    }
    NSLog(@"---%@",soapStr);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[MZNetWorkURLManager shareConfig][url]]];
    request.timeoutInterval = 60;
    // 访问方式
    [request setHTTPMethod:@"POST"];
    
    // 设置请求头(请求头也可以不设置，前两个设不设置都一样，应该默认的，但是SOAPAction我怎么都设置不对，不设置也可以，干脆不设置了)
    [request addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%zd", soapStr.length] forHTTPHeaderField:@"Content-Length"];
    NSString * stringhttp = [NSString stringWithFormat:@"http://tempuri.org/%@", name];
    [request addValue:stringhttp forHTTPHeaderField:@"SOAPAction"];
    
    // body内容
    [request setHTTPBody:[soapStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;

}


@end
