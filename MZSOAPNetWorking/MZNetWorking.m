//
//  MZNetWorking.m
//  长江实验小学
//
//  Created by 慕子 on 2017/6/26.
//  Copyright © 2017年 MZ. All rights reserved.
//

#import "MZNetWorking.h"
#import "MZXMLParser.h"
#import "MZNetWorkTool.h"

#define WS(weakSelf,Views)  __weak typeof(Views) weakSelf = Views

@interface MZNetWorking()

@property (nonatomic, copy)mz_requestNetResult block;

@end

@implementation MZNetWorking


+ (instancetype)share {
    static MZNetWorking * mzNetWorkingShare = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mzNetWorkingShare = [[MZNetWorking alloc] init];
    });
    return mzNetWorkingShare;
}

- (void)authenticationName:(NSString *)authenticationName requestDic:(NSDictionary *)dict result:(mz_requestNetResult)block {
    self.block = block;
    
    WS(weakSelf, self);
    
    NSString * result = [NSString stringWithFormat:@"%@Result",authenticationName];
    
    NSMutableURLRequest *request;
    request = [MZNetWorkTool JSONOFSOAPWith:dict URL:authenticationName authenticationName:authenticationName jsonName:@"json"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Session----失败----%@", error.localizedDescription);
            if (weakSelf.block) {
                weakSelf.block(0, [error.localizedDescription copy], nil);
            }
        } else {
            [[MZXMLParser shared] XMLParserWithData:data withMethodName:result parserResult:^(BOOL success, NSString *result) {
                if (success) {
                    NSLog(@"%@", result);
                    NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                    if (weakSelf.block) {
                        weakSelf.block(1, nil, [dic copy]);
                    }
                    
                } else {
                    if (weakSelf.block) {
                        weakSelf.block(0, [result copy], nil);
                    }
                }
            }];
        }
        
    }];
    
    [task resume];
}


- (void)authenticationName:(NSString *)authenticationName requestArray:(NSArray *)array result:(mz_requestNetResult)block {
    self.block = block;
    
    WS(weakSelf, self);
    
    NSString * result = [NSString stringWithFormat:@"%@Result",authenticationName];
    
    NSMutableURLRequest *request;
    request = [MZNetWorkTool JSONOFSOAPWithArray:array URL:authenticationName authenticationName:authenticationName jsonName:@"json"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Session----失败----%@", error.localizedDescription);
            if (weakSelf.block) {
                weakSelf.block(0, [error.localizedDescription copy], nil);
            }
        } else {
            [[MZXMLParser shared] XMLParserWithData:data withMethodName:result parserResult:^(BOOL success, NSString *result) {
                if (success) {
                    NSLog(@"%@", result);
                    NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                    if (weakSelf.block) {
                        weakSelf.block(1, nil, [dic copy]);
                    }
                    
                } else {
                    if (weakSelf.block) {
                        weakSelf.block(0, [result copy], nil);
                    }
                }
            }];
        }
        
    }];
    
    [task resume];
}





@end
