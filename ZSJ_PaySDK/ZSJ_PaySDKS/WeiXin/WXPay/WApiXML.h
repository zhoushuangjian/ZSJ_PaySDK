//
//  WApiXML.h
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WApiXML : NSObject<NSXMLParserDelegate>
{
    //解析器
    NSXMLParser *xmlParser;
    //解析元素
    NSMutableArray *xmlElements;
    //解析结果
    NSMutableDictionary *dictionary;
    //临时串变量
    NSMutableString *contentString;
}
// 开始解析 XML
-(void)StartAnalysisData:(NSData*)data;
// 获取解析后的数据
-(NSMutableDictionary*)GetAnalysisData;
@end
